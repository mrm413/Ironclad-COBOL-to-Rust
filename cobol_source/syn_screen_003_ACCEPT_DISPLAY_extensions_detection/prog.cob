IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  zero-const CONSTANT 0.
       01  x PIC 99.

       SCREEN SECTION.
       01  scr.
           03  y PIC 99 FROM x LINE 3 COLUMN 5.

       PROCEDURE DIVISION.
           DISPLAY "hello" AT 0000
           DISPLAY "world" LINE ZERO COLUMN zero-const
           ACCEPT x WITH TIME-OUT 5

           DISPLAY scr WITH UNDERLINE
           ACCEPT scr WITH HIGHLIGHT

           DISPLAY scr, scr

           *> Valid statements
           DISPLAY scr UPON CRT-UNDER
           ACCEPT scr AT LINE 4 COLUMN 4
           .