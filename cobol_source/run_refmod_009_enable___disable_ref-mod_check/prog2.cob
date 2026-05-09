IDENTIFICATION DIVISION.
       PROGRAM-ID. prog2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x.
           03  y PIC X VALUE "a".
           03  z PIC X VALUE "b".
       01  len   PIC 99 VALUE 0.

       PROCEDURE DIVISION.
           DISPLAY y (1:len)
                   WITH NO ADVANCING
           DISPLAY FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
                   WITH NO ADVANCING
           DISPLAY "."
                   WITH NO ADVANCING
           MOVE    2 TO len
           DISPLAY y (1:len)
                   WITH NO ADVANCING
           DISPLAY FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
                   WITH NO ADVANCING
           DISPLAY "."
                   WITH NO ADVANCING
           .