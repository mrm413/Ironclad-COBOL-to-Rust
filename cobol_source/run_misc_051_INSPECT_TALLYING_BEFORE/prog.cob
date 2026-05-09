IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "ABC ".
       01 TAL           PIC 999 VALUE 0.
       PROCEDURE        DIVISION.
           MOVE 0 TO TAL.
           INSPECT X TALLYING TAL FOR CHARACTERS
                     BEFORE INITIAL " ".
           IF TAL NOT = 3
              DISPLAY "1: should be 3 but is " TAL.

           MOVE 0 TO TAL.
           MOVE " ABC" TO X.
           INSPECT X TALLYING TAL FOR CHARACTERS
                     BEFORE INITIAL " ".
           IF TAL NOT = 0
              DISPLAY "2: should be 0 but is " TAL.

           STOP RUN.