IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  zero-var PIC 9 VALUE 0.

       SCREEN SECTION.
       01  scr.
           03  VALUE "a".

       PROCEDURE DIVISION.
           DISPLAY scr AT LINE zero-var
           IF FUNCTION EXCEPTION-STATUS <> "EC-SCREEN-LINE-NUMBER"
               GOBACK RETURNING 1
           END-IF

           DISPLAY scr AT COLUMN zero-var
           IF FUNCTION EXCEPTION-STATUS <> "EC-SCREEN-STARTING-COLUMN"
               GOBACK RETURNING 2
           END-IF

           GOBACK RETURNING 0
           .