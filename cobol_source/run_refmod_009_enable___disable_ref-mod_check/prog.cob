IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x.
           03  y PIC XXX VALUE "abc".
           03  z PIC X VALUE "d".
       01  len PIC 99 VALUE 2.

       PROCEDURE DIVISION.
           DISPLAY y (3:len)
                   WITH NO ADVANCING
           DISPLAY FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
                   WITH NO ADVANCING
           DISPLAY "."
                   WITH NO ADVANCING
           .