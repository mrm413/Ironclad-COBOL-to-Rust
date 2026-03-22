IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  x           PIC 9(5) VALUE 1.
       01  y           CONSTANT "ab".

       PROCEDURE       DIVISION.
           STOP x
           STOP y
           .