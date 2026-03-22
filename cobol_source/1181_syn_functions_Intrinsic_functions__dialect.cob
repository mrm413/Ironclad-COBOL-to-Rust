IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           DISPLAY FUNCTION ABS (1).
           DISPLAY FUNCTION STORED-CHAR-LENGTH (" some text here").
           DISPLAY FUNCTION SUBSTITUTE ('some text' 'some' 'nice').
           STOP RUN.