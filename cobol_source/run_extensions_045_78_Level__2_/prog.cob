IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Z.
       78  X            VALUE "OK".
       78  Y            VALUE "OK".
           03  FILLER   PIC XX VALUE "OK".
       PROCEDURE        DIVISION.
           DISPLAY X Z Y
           END-DISPLAY.
           STOP RUN.