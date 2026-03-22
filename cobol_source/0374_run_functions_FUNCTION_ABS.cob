IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X   PIC   S9(4)V9(4) VALUE -1.2345.
       PROCEDURE        DIVISION.
           DISPLAY FUNCTION ABS ( X ) NO ADVANCING
           END-DISPLAY.
           STOP RUN.