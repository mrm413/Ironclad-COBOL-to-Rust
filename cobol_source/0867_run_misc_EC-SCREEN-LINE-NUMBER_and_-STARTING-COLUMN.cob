IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.

       DATA           DIVISION.
       SCREEN         SECTION.
       01  invalid-line.
           03  a      VALUE "a" LINE 99999999.
       01  invalid-col.
           03  c      VALUE "c" COLUMN 99999999.

       PROCEDURE      DIVISION.
           DISPLAY invalid-line END-DISPLAY
           IF FUNCTION EXCEPTION-STATUS = "EC-SCREEN-LINE-NUMBER"
               CONTINUE
           ELSE
               GOBACK RETURNING 1
           END-IF

           DISPLAY invalid-col END-DISPLAY
           IF FUNCTION EXCEPTION-STATUS = "EC-SCREEN-STARTING-COLUMN"
               CONTINUE
           ELSE
               GOBACK RETURNING 2
           END-IF

           GOBACK RETURNING 0
           .