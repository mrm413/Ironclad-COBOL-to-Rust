IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        PROGRAM COLLATING SEQUENCE IS ALPHABET-1,
                                                      ALPHABET-2.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS
                    'A' THROUGH 'Z', x'00' thru x'05'.
           ALPHABET ALPHABET-2
                    n'A' also n'B' ALSO n'f',
                    n'g' also n'G', n'1' thru n'9'.
       END PROGRAM prog3.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3b.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        PROGRAM           SEQUENCE IS ALPHABET-1,
                                                      ALPHABET-2.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS
                    'A' THROUGH 'Z', x'00' thru x'05'.
           ALPHABET ALPHABET-2 IS
                    n'A' ALSO n'f',
                    n'g' also n'G'.
       END PROGRAM prog3b.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3c.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE, SEQUENCE ALPHABET-1, ALPHABET-2.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1    x'00' thru x'05'.
           ALPHABET ALPHABET-2 IS n'g' also n'G', n'1' thru n'9'.
       END PROGRAM prog3c.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3d.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE, SEQUENCE ALPHABET-1, ALPHABET-2.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS 'A' THROUGH 'Z'.
           ALPHABET ALPHABET-2   n'A' also n'B', n'1' thru n'9'.
       END PROGRAM prog3d.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3e.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE, SEQUENCE ALPHABET-1.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS 'Z', x'00'.
       END PROGRAM prog3e.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3f.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        COLLATING SEQUENCE
                          FOR ALPHANUMERIC IS ALPHABET-1.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS
                    'A' THROUGH 'Z', x'00', x'05'.
       END PROGRAM prog3f.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3g.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        SEQUENCE ALPHANUMERIC ALPHABET-1.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS
                    'A' THROUGH 'D'.
       END PROGRAM prog3g.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3h.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        COLLATING SEQUENCE
                          FOR ALPHANUMERIC IS ALPHABET-1
                              NATIONAL     IS ALPHABET-2.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS
                    'A', 'C', x'05'.
           ALPHABET ALPHABET-2
                    n'A', n'1' thru n'9'.
       END PROGRAM prog3h.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3i.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        COLLATING SEQUENCE
                          NATIONAL     ALPHABET-2
                          ALPHANUMERIC ALPHABET-1.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-1 IS
                    'a' THROUGH 'z'.
           ALPHABET ALPHABET-2
                    n'B', n'C'; n'g' also n'G'.
       END PROGRAM prog3i.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3j.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. GNU-LINUX.
       OBJECT-COMPUTER. GC-MACHINE,
                        COLLATING SEQUENCE
                          NATIONAL     ALPHABET-2.
       SPECIAL-NAMES.
           ALPHABET ALPHABET-2
                    n'B', n'C'; n'g' also n'G'.
       END PROGRAM prog3j.