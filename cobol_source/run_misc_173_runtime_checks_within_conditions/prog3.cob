IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog3.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 mytab.
          03  VAR                   PIC  9(02) value 1.
          03  VAR2                  PIC  9(02) value 99.
          03                        OCCURS 2.
           05 T15-PRGM              PIC  X(08).
           05 T16-PRGM              PIC  X(08).
          03                        OCCURS 2.
           05 T15-NRGM              PIC  9(04).
           05 T16-NRGM              USAGE BINARY-INT.

       PROCEDURE DIVISION.

           IF  MYTAB(VAR:VAR2)
      *>     = MYTAB(VAR2:VAR)   that _should_ work but on x86_64
      *>                         the second line is evaluated first
             = MYTAB(VAR:VAR )
              DISPLAY 'WRONG RESULT REFMOD'.

           GOBACK.