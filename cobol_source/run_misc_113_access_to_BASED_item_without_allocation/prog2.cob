IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             BASED.
          05 Y          PIC X(4).
       PROCEDURE        DIVISION.
           DISPLAY Y NO ADVANCING
           STOP RUN.