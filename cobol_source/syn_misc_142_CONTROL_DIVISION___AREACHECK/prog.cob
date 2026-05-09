CONTROL          DIVISION.
       SUBSTITUTION     SECTION.
      *> This REPLACE in Area A is ignored for now:
          REPLACE IISS BY IS
                  TERM BY TERMINAL
                  "KO" BY "OK".
       DEFAULT          SECTION.
          ACCEPT ALTERNATE CONSOLE
          DISPLAY IISS TERM
       .
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 VAR PIC X(2) VALUE "KO".
       PROCEDURE        DIVISION.
          DISPLAY VAR
          STOP RUN.