IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "ABC ".
       01 TAL           PIC 999 VALUE 0.
       01 MSG           PIC X(256) VALUE SPACES.
       PROCEDURE        DIVISION.
           MOVE 0 TO TAL.
           INSPECT X TALLYING TAL FOR CHARACTERS
                     BEFORE INITIAL " "
                     AFTER   " ".
           IF TAL NOT = 0
              DISPLAY "1: should be 0 but is " TAL.

      *> checking for no match, includes bug #865
           MOVE 0 TO TAL.
           INSPECT MSG TALLYING TAL FOR CHARACTERS
               AFTER INITIAL "<"
               BEFORE INITIAL "</".
           IF TAL NOT = 0
              DISPLAY "2: should be 0 but is " TAL.

           STOP RUN.