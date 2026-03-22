IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  YYYYMMDD     PIC 9 VALUE 0.
       01  X            PIC X(16).
       PROCEDURE        DIVISION.
           ACCEPT X FROM DATE YYYYMMDD
           END-ACCEPT.
           DISPLAY YYYYMMDD NO ADVANCING
           END-DISPLAY.
           STOP RUN.