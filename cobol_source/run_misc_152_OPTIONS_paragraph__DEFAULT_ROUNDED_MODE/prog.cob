IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.
       OPTIONS.
           DEFAULT ROUNDED NEAREST-EVEN.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  x           PIC 9.

       PROCEDURE       DIVISION.
           COMPUTE x ROUNDED = 1.5
           DISPLAY x
           COMPUTE x ROUNDED = 2.5
           DISPLAY x
           .