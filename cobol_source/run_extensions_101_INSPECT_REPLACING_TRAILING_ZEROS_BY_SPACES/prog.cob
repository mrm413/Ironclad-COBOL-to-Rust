IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "1000".
       PROCEDURE        DIVISION.
           INSPECT X REPLACING TRAILING ZEROS BY SPACES.
           IF X NOT = "1   "
              DISPLAY X.
           STOP RUN.