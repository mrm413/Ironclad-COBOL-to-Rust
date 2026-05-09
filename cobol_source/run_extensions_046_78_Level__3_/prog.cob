IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78  X            VALUE "OK".
       01  Z            PIC XX VALUE "OK".
       PROCEDURE        DIVISION.
           DISPLAY Z X
           END-DISPLAY.
           STOP RUN.