IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  comp1       COMP-1.
       01  num         PIC 9.9.

       PROCEDURE       DIVISION.
           COMPUTE comp1 = 7 / 2
           MOVE comp1 TO num
           DISPLAY num
           .