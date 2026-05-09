IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  TERMINAL     PIC XX VALUE "OK".
       01  SEND         PIC XX VALUE "OK".
       PROCEDURE        DIVISION.
           DISPLAY TERMINAL SEND.
           STOP RUN.