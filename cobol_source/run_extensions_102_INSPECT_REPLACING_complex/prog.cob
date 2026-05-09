IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(12) VALUE "AZABBCDCCECC".
       PROCEDURE        DIVISION.
           INSPECT X REPLACING
             ALL      "A" BY "Z"
                      "B" BY "Y"
                      "Z" BY "0"
             TRAILING "C" BY "X"
           IF X NOT = "Z0ZYYCDCCEXX"
              DISPLAY "1 - " X.

           INSPECT X REPLACING
             CHARACTERS BY SPACES
              BEFORE  "C" AFTER "0"
             CHARACTERS BY ZEROES
              BEFORE  "E" AFTER "C"
           IF X NOT = "Z0   C000EXX"
              DISPLAY "2 - " X.

           STOP RUN.