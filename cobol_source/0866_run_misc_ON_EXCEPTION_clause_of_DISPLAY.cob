IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       PROCEDURE DIVISION.
           DISPLAY "hello" AT COLUMN 500
               ON EXCEPTION
                   GOBACK RETURNING 0
               NOT ON EXCEPTION
                   GOBACK RETURNING 1
           END-DISPLAY
           .