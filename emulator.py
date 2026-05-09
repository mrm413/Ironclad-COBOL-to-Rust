"""
Core VT100 terminal emulator.

Wraps pyte Screen + a PtyProcess (winpty on Windows, ptyprocess on Linux)
to run a program in a virtual terminal, capture screen buffer state, and
provide scripted input.
"""

import sys
import time
import threading
from typing import Optional
from dataclasses import dataclass, field

import pyte

# Cross-platform PtyProcess shim. winpty.PtyProcess and ptyprocess.PtyProcess
# expose the same spawn/read/write/isalive/terminate API; pick whichever is
# available so this module works on both Windows and Linux.
if sys.platform == "win32":
    from winpty import PtyProcess  # type: ignore[import-not-found]
else:
    from ptyprocess import PtyProcess  # type: ignore[import-not-found]


@dataclass
class ScreenCapture:
    """Snapshot of the terminal screen at a point in time."""
    lines: list[str]
    cursor_row: int
    cursor_col: int
    timestamp: float
    rows: int
    cols: int

    @property
    def text(self) -> str:
        """Full screen content with trailing whitespace stripped per line."""
        return "\n".join(line.rstrip() for line in self.lines)

    @property
    def display_text(self) -> str:
        """Non-empty lines only (for compact output)."""
        result = []
        for line in self.lines:
            stripped = line.rstrip()
            if stripped:
                result.append(stripped)
        return "\n".join(result)

    @property
    def positioned_text(self) -> str:
        """Lines with their row numbers (for screen-position-aware comparison)."""
        result = []
        for i, line in enumerate(self.lines, 1):
            stripped = line.rstrip()
            if stripped:
                result.append(f"{i:02d}|{stripped}")
        return "\n".join(result)


class TerminalEmulator:
    """
    Virtual terminal that runs a program via ConPTY and captures its screen output.

    Usage:
        emu = TerminalEmulator(rows=25, cols=80)
        emu.start("prog.exe")
        emu.wait_for_stable(timeout=3.0)
        capture = emu.capture()
        emu.send_input("y\\r\\n")
        emu.wait_for_exit(timeout=5.0)
        final = emu.capture()
        emu.close()
    """

    def __init__(self, rows: int = 25, cols: int = 80):
        self.rows = rows
        self.cols = cols
        self.screen = pyte.Screen(cols, rows)
        self.stream = pyte.Stream(self.screen)
        self.process: Optional[PtyProcess] = None
        self._reader_thread: Optional[threading.Thread] = None
        self._stop_reader = threading.Event()
        self._output_lock = threading.Lock()
        self._raw_output: list[str] = []
        self._last_change_time = 0.0

    def start(self, command: str, cwd: str = None, env: dict = None,
              timeout: float = 10.0) -> None:
        """Start a program in the virtual terminal."""
        self.screen.reset()
        self._raw_output = []
        self._stop_reader.clear()
        self._last_change_time = time.time()

        # ptyprocess (Linux) requires argv list; winpty (Windows) accepts either.
        if sys.platform != "win32" and isinstance(command, str):
            argv = [command]
        else:
            argv = command
        self.process = PtyProcess.spawn(
            argv,
            cwd=cwd,
            env=env,
            dimensions=(self.rows, self.cols)
        )

        self._reader_thread = threading.Thread(
            target=self._read_output_loop,
            daemon=True
        )
        self._reader_thread.start()

    def _read_output_loop(self) -> None:
        """Background thread: continuously read PTY output and feed to pyte."""
        while not self._stop_reader.is_set():
            try:
                data = self.process.read(4096)
                if data:
                    # ptyprocess (Linux) returns bytes; winpty (Windows) returns str.
                    if isinstance(data, bytes):
                        data = data.decode("utf-8", errors="replace")
                    with self._output_lock:
                        self._raw_output.append(data)
                        self.stream.feed(data)
                        self._last_change_time = time.time()
            except EOFError:
                # Process closed its PTY — drain any remaining data
                try:
                    remaining = self.process.read(65536)
                    if remaining:
                        if isinstance(remaining, bytes):
                            remaining = remaining.decode("utf-8", errors="replace")
                        with self._output_lock:
                            self._raw_output.append(remaining)
                            self.stream.feed(remaining)
                            self._last_change_time = time.time()
                except Exception:
                    pass
                break
            except Exception:
                if self.process is None or not self.process.isalive():
                    break
                time.sleep(0.02)

    def send_input(self, text: str) -> None:
        """Send text input to the running program."""
        if self.process and self.process.isalive():
            # ptyprocess wants bytes; winpty accepts str.
            if sys.platform != "win32":
                self.process.write(text.encode("utf-8"))
            else:
                self.process.write(text)

    def send_key(self, key: str) -> None:
        """Send a special key. Supported: enter, tab, escape, up, down, left, right, f1-f12."""
        key_map = {
            "enter": "\r\n",
            "tab": "\t",
            "escape": "\x1b",
            "up": "\x1b[A",
            "down": "\x1b[B",
            "right": "\x1b[C",
            "left": "\x1b[D",
            "backspace": "\x08",
            "delete": "\x1b[3~",
            "home": "\x1b[H",
            "end": "\x1b[F",
            "f1": "\x1bOP",
            "f2": "\x1bOQ",
            "f3": "\x1bOR",
            "f4": "\x1bOS",
            "f5": "\x1b[15~",
            "f6": "\x1b[17~",
            "f7": "\x1b[18~",
            "f8": "\x1b[19~",
            "f9": "\x1b[20~",
            "f10": "\x1b[21~",
            "f11": "\x1b[23~",
            "f12": "\x1b[24~",
        }
        seq = key_map.get(key.lower())
        if seq:
            self.send_input(seq)
        else:
            raise ValueError(f"Unknown key: {key}")

    def wait_for_stable(self, timeout: float = 3.0,
                         settle_time: float = 0.5) -> bool:
        """
        Wait until the screen hasn't changed for `settle_time` seconds,
        or until `timeout` is reached. Returns True if screen stabilized.
        """
        deadline = time.time() + timeout
        while time.time() < deadline:
            elapsed = time.time() - self._last_change_time
            if elapsed >= settle_time:
                return True
            time.sleep(0.05)
        return False

    def wait_for_text(self, text: str, timeout: float = 5.0) -> bool:
        """Wait until specific text appears on the screen."""
        deadline = time.time() + timeout
        while time.time() < deadline:
            with self._output_lock:
                display = "\n".join(self.screen.display)
            if text in display:
                return True
            time.sleep(0.05)
        return False

    def wait_for_exit(self, timeout: float = 10.0) -> Optional[int]:
        """Wait for the program to exit. Returns exit code or None on timeout."""
        if self.process is None:
            return None
        deadline = time.time() + timeout
        while time.time() < deadline:
            if not self.process.isalive():
                if self._reader_thread:
                    self._reader_thread.join(timeout=2.0)
                return self.process.exitstatus
            time.sleep(0.05)
        return None

    def capture(self) -> ScreenCapture:
        """Take a snapshot of the current screen state."""
        with self._output_lock:
            lines = list(self.screen.display)
            cursor_row = self.screen.cursor.y
            cursor_col = self.screen.cursor.x

        return ScreenCapture(
            lines=lines,
            cursor_row=cursor_row,
            cursor_col=cursor_col,
            timestamp=time.time(),
            rows=self.rows,
            cols=self.cols
        )

    def capture_peak(self, chunk_size: int = 50) -> ScreenCapture:
        """
        Capture the screen state with the most content.

        Algorithm: legacy first-strictly-greater max-rows, BUT when multiple
        chunks share the peak row count, prefer chunks whose currently non-
        empty rows are all "anchored" (each row is also non-empty in some
        later chunk that itself reaches the same peak count). This rejects
        transient rows that flash on for a chunk then disappear (e.g. test
        040: "123456789" written to row 7 then immediately cleared).

        Tests like 046 still get the first chunk at peak (their rows persist
        through subsequent peak-count chunks, so they're "anchored"). Tests
        like 025 (BLANK SCREEN clears max-row frame) still get the legacy
        first-peak chunk because no LATER chunk re-reaches that peak — there
        are no anchored alternatives, so the first-peak chunk wins by default.
        """
        with self._output_lock:
            raw = "".join(self._raw_output)

        _trailer = "end of program, please press a key to exit"

        def _is_trailer(line: str) -> bool:
            stripped = line.rstrip()
            return len(stripped) >= 2 and _trailer.startswith(stripped)

        def _is_content(line: str) -> bool:
            stripped = line.rstrip()
            return bool(stripped) and not _is_trailer(line)

        def _content_count(lines: list[str]) -> int:
            return sum(1 for ln in lines if _is_content(ln))

        screen = pyte.Screen(self.cols, self.rows)
        stream = pyte.Stream(screen)

        # Pass 1: collect snapshots and per-chunk row content/count.
        snapshots: list[tuple[list[str], tuple[int, int]]] = []
        chunk_counts: list[int] = []
        # row_chunks[r] = sorted list of chunk indices where row r is non-empty
        row_chunks: dict[int, list[int]] = {}
        for i in range(0, len(raw), chunk_size):
            chunk = raw[i:i + chunk_size]
            stream.feed(chunk)
            lines = list(screen.display)
            snapshots.append((lines, (screen.cursor.y, screen.cursor.x)))
            chunk_counts.append(_content_count(lines))
            for r, ln in enumerate(lines):
                if _is_content(ln):
                    row_chunks.setdefault(r, []).append(len(snapshots) - 1)

        if not snapshots:
            return ScreenCapture(
                lines=[" " * self.cols] * self.rows,
                cursor_row=0, cursor_col=0,
                timestamp=time.time(),
                rows=self.rows, cols=self.cols,
            )

        peak_count = max(chunk_counts) if chunk_counts else 0
        if peak_count == 0:
            best_lines, best_cursor = snapshots[0]
            return ScreenCapture(
                lines=best_lines,
                cursor_row=best_cursor[0], cursor_col=best_cursor[1],
                timestamp=time.time(),
                rows=self.rows, cols=self.cols,
            )

        # Indices of all chunks at peak row count.
        peak_indices = [i for i, c in enumerate(chunk_counts) if c == peak_count]

        def _row_anchored(r: int, idx: int) -> bool:
            """Row r at chunk idx is anchored iff r is non-empty in some
            chunk >= idx that itself is at peak count."""
            chunks_with_r = row_chunks.get(r, [])
            for c in chunks_with_r:
                if c >= idx and chunk_counts[c] == peak_count and r < len(snapshots[c][0]):
                    if _is_content(snapshots[c][0][r]):
                        # Found another peak chunk where r is non-empty
                        if c != idx:
                            return True
            # If only THIS chunk has r at peak count, r is anchored iff this
            # is the LAST peak chunk (i.e. r doesn't get cleared after).
            # Equivalently: r non-empty in all chunks from idx through last
            # peak chunk.
            last_peak = peak_indices[-1]
            for c in range(idx, last_peak + 1):
                if r >= len(snapshots[c][0]) or not _is_content(snapshots[c][0][r]):
                    return False
            return True

        def _all_rows_anchored(idx: int) -> bool:
            lines = snapshots[idx][0]
            for r, ln in enumerate(lines):
                if _is_content(ln) and not _row_anchored(r, idx):
                    return False
            return True

        # Prefer first peak chunk where all rows are anchored. Fall back to
        # legacy first-peak chunk if none qualify.
        chosen = peak_indices[0]
        for idx in peak_indices:
            if _all_rows_anchored(idx):
                chosen = idx
                break

        best_lines, best_cursor = snapshots[chosen]
        return ScreenCapture(
            lines=best_lines,
            cursor_row=best_cursor[0],
            cursor_col=best_cursor[1],
            timestamp=time.time(),
            rows=self.rows,
            cols=self.cols
        )

    @property
    def raw_output(self) -> str:
        """All raw bytes received from the PTY (for debugging)."""
        with self._output_lock:
            return "".join(self._raw_output)

    @property
    def is_alive(self) -> bool:
        return self.process is not None and self.process.isalive()

    def close(self) -> None:
        """Terminate the process and clean up."""
        self._stop_reader.set()
        if self.process:
            try:
                if self.process.isalive():
                    self.process.terminate(force=True)
            except Exception:
                pass
        if self._reader_thread:
            self._reader_thread.join(timeout=3.0)
        self.process = None
