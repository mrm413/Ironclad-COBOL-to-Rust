IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           ALPHABET TESTME IS
                    'A' THROUGH 'Z', x'00' thru x'05';
                    x'41' ALSO x'42', ALSO x'00', x'C1' ALSO x'C2'.
           ALPHABET FINE
                    'A' also 'B' also 'C' also 'd' also 'e' ALSO 'f',
                    'g' also 'G', '1' thru '9', x'00'.