"""
parity_filter.py — decide whether a COBOL test program is "runnable headless"
for byte-for-byte parity verification.

A test is excluded when running it under cobc would produce non-deterministic
output (timestamps, random PIDs) or hang waiting for keyboard input. That's
not a parity failure — it's a category we deliberately can't compare in CI.

Outputs SKIP <reason> on stdout if the program is excluded; nothing if runnable.
"""
import re
import sys
from pathlib import Path


def detect_skip(content: str) -> str | None:
    upper = content.upper()

    # Interactive: bare ACCEPT (no FROM clause) reads stdin -> would hang in CI.
    for line in content.splitlines():
        body = line[6:] if len(line) > 6 else line
        if body.lstrip().startswith("*"):
            continue
        if re.match(r"\s*ACCEPT\s+[\w-]+\s*(\.\s*$|$)", body, re.I) and "FROM" not in body.upper():
            return "interactive ACCEPT (stdin)"

    # Volatile: FUNCTION CURRENT-DATE / WHEN-COMPILED / ACCEPT FROM TIME — output
    # changes every run. Allowed if the program then strips the volatile bytes,
    # but that's hard to detect statically; conservatively skip.
    if "WHEN-COMPILED" in upper:
        return "volatile WHEN-COMPILED"
    if "ACCEPT" in upper and re.search(r"ACCEPT\s+\w[\w-]*\s+FROM\s+(TIME|CURRENT-DATE|DAY-OF-WEEK|DAY)\b", upper):
        # FROM DATE is OK if then formatted; FROM TIME is always volatile.
        if "FROM TIME" in upper:
            return "volatile ACCEPT FROM TIME"

    # Subsystems we don't ship in the stripped-down runtime image.
    if "EXEC SQL" in upper:
        return "DB2 / EXEC SQL"
    if "EXEC CICS" in upper:
        return "CICS (use carddemo / IBM-genapp showcase for CICS parity)"

    # Required external data files (FILE-CONTROL with non-stdin assignment) —
    # parity environment doesn't stage data files; status 35 noise diverges.
    # This is a coarse filter; conservative skip avoids false failures.
    if re.search(r"\bSELECT\b[^.]*\bASSIGN\b", upper):
        return "external file (data not staged in parity image)"

    return None


def main():
    if len(sys.argv) != 2:
        sys.stderr.write("usage: parity_filter.py <prog.cob>\n")
        sys.exit(2)
    path = Path(sys.argv[1])
    content = path.read_text(errors="replace")
    reason = detect_skip(content)
    if reason:
        print(f"SKIP {reason}")


if __name__ == "__main__":
    main()
