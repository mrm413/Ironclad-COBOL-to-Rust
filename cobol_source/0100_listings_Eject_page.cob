IDENTIFICATION   DIVISION.

       PROGRAM-ID.      prog3.


       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 WS-VAR PIC X(2).
      /
       77 WS-VA2 PIC X(2).


       LOCAL-STORAGE  SECTION.
       77 LS-VAR PIC 9(2).


       PROCEDURE        DIVISION.

           DISPLAY WS-VAR
           MOVE 99 TO LS-VAR

           STOP RUN.