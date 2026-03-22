IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(3) VALUE LOW-VALUES.
       PROCEDURE        DIVISION.
           INSPECT X CONVERTING NULL TO "A".
           IF X NOT = "AAA"
              DISPLAY X.
           STOP RUN.