IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  x            PIC 9, BLANK WHEN ZERO, VALUE 1.

       PROCEDURE        DIVISION.
           DISPLAY x
           MOVE 0 TO x
           DISPLAY FUNCTION TRIM(x)
           MOVE ZERO TO x
           DISPLAY FUNCTION TRIM(x)
           .