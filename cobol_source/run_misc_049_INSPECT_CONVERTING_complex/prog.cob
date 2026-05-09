IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(12) VALUE "AZABBCDCCECC".
       PROCEDURE        DIVISION.
           INSPECT X CONVERTING "ABZC" TO "ZY0X"
           IF X NOT = "Z0ZYYXDXXEXX"
              DISPLAY "1 - " X
              MOVE "Z0ZYYXDXXEXX" TO X.

           INSPECT X CONVERTING "XD" TO SPACES
              BEFORE  "E" AFTER "D"
           IF X NOT = "Z0ZYYXD  EXX"
              DISPLAY "2 - " X
              MOVE "Z0ZYYXD  EXX" TO X.

           STOP RUN.