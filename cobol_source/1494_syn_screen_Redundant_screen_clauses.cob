IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  x            PIC 999.

       SCREEN           SECTION.
       01  scr.
           03  HIGHLIGHT FULL.
               05  HIGHLIGHT FULL.
                   07  FULL FULL VALUE "foo".

       PROCEDURE        DIVISION.
           DISPLAY "hello" WITH BACKGROUND-COLOR 2, BACKGROUND-COLOR 2
           ACCEPT x WITH HIGHLIGHT, HIGHLIGHT, UPDATE, DEFAULT
           .