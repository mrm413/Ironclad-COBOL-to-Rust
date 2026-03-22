IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x VALUE "12345!".
           03  y PIC X OCCURS 5 TIMES.
           03  z PIC X VALUE "!".
       01  idx PIC 99 VALUE 6.
           
       PROCEDURE DIVISION.
           DISPLAY y (idx)
                   WITH NO ADVANCING
           DISPLAY FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
                   WITH NO ADVANCING
           .