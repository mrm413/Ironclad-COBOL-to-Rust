* Sample program in X/Open free-form format.

IDENTIFICATION   DIVISION.
PROGRAM-ID.      prog.
DATA             DIVISION.
WORKING-STORAGE  SECTION.
PROCEDURE        DIVISION.
/ Beginning of the code
DISPLAY "OK" NO ADVANCING
* If debug:
D DISPLAY "KO" NO ADVANCING
STOP RUN.