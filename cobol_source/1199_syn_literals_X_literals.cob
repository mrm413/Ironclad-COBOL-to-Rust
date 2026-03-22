IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.
       PROCEDURE      DIVISION.
           *> Valid form
           DISPLAY X"0123456789ABCDEF"

           *> invalid form
           DISPLAY X"GH"
                   X"1"
           END-DISPLAY.