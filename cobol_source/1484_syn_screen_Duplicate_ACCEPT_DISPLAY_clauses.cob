IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  a-field      PIC XXX.
       PROCEDURE        DIVISION.
           DISPLAY "foo" LINE 1 COL 1 HIGHLIGHT LINE 1 HIGHLIGHT
               AT 0101 MODE IS BLOCK MODE IS BLOCK
           ACCEPT a-field LINE 1 COL 1 HIGHLIGHT LINE 1 HIGHLIGHT
               AT 0101
           .