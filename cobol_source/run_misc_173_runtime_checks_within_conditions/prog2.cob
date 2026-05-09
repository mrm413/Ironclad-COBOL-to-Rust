IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 mytab.
          03  VAR                   PIC  9(02) value 1.
          03  VAR2                  PIC  9(02) value 3.
          03                        OCCURS 2.
           05 T15-PRGM              PIC  X(08).
           05 T16-PRGM              PIC  X(08).
          03                        OCCURS 2.
           05 T15-NRGM              PIC  9(04).
           05 T16-NRGM              USAGE BINARY-INT.
          05 buffer                 PIC X(500).

       PROCEDURE DIVISION.
      *
           IF  T16-PRGM(VAR)
             = T15-PRGM(VAR2)
              DISPLAY 'WRONG RESULT OCCURS'.

           GOBACK.