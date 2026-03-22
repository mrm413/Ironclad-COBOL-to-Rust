IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  NORMAL       PIC 9 VALUE 0.
       PROCEDURE        DIVISION.
           DISPLAY NORMAL NO ADVANCING *> Intentionally no period or END-DISPLAY
           STOP RUN NORMAL.