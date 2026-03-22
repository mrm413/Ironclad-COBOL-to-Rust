IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  x PIC 9(4)  COMP.

       PROCEDURE       DIVISION.
           MOVE 30000 TO x
           PERFORM check-x-val

           COMPUTE x = 30000
           PERFORM check-x-val

           MOVE ZERO TO x
           ADD 30000 TO x
           PERFORM check-x-val

           GOBACK
           .
       check-x-val     SECTION.
           EVALUATE x
               WHEN 30000
                   DISPLAY "x IS 30000"

               WHEN >= 10000
                   DISPLAY "x >= 10000"

               WHEN ZERO
                   DISPLAY "x IS ZERO"

               WHEN OTHER
                   CONTINUE
           END-EVALUATE
           .
       END PROGRAM prog.