IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 mytab.
          03  VAR                   PIC  9(02) value 1.
          03  VAR2                  PIC  9(02) value 2.
          03                        OCCURS 2.
           05 T15-PRGM              PIC  X(08).
           05 T16-PRGM              PIC  X(08).
          03                        OCCURS 2.
           05 T15-NRGM              PIC  9(04).
           05 T16-NRGM              USAGE BINARY-INT.

       PROCEDURE DIVISION.
      *
           MOVE 'TESTME' TO T16-PRGM (VAR) (VAR2:)
           MOVE T16-PRGM (VAR) (1:VAR2) TO T15-PRGM (VAR)
           IF  T16-PRGM(VAR)
             = T15-PRGM(VAR2)
              DISPLAY 'WRONG RESULT OCCURS'.

           IF  MYTAB(VAR:VAR2)
             = MYTAB(VAR2:VAR)
              DISPLAY 'WRONG RESULT REFMOD'.

           INITIALIZE mytab

           GOBACK.