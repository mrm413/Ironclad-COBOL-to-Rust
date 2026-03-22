IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.
       PROCEDURE      DIVISION.
           *> Valid form
           DISPLAY NX"265E"
           DISPLAY NX"0123456789ABCDEF"

           *> invalid form
           DISPLAY NX"GH"
                   NX"1".