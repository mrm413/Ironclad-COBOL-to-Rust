* Sample program in ACU terminal format.

IDENTIFICATION   DIVISION.
PROGRAM-ID.      prog.
AUTHOR.
    Somebody.
\D    Somebody else.
    One last author.
DATA             DIVISION.
WORKING-STORAGE  SECTION.
PROCEDURE        DIVISION.
      DISPLAY "OK" NO ADVANCING
      END-DISPLAY.
\D    DISPLAY "KO" NO ADVANCING
\D    END-DISPLAY.
      STOP RUN.