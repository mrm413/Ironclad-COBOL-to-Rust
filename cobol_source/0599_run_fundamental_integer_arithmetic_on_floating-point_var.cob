IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  x           USAGE FLOAT-SHORT VALUE 123.456.

       PROCEDURE       DIVISION.
           ADD 360 TO x
           IF x <> 483.456
               DISPLAY "ADD wrong: " x
               MOVE 483.456 TO x
           END-IF

           SUBTRACT 360 FROM x
           IF x <> 123.456
               DISPLAY "SUBTRACT wrong: " x
               MOVE 123.456 TO x
           END-IF

           DIVIDE 2 INTO x
           IF x <> 61.728
               DISPLAY "DIVIDE wrong: " x
               MOVE 61.728 TO x
           END-IF

           MULTIPLY 2 BY x
           IF x <> 123.456
               DISPLAY "MULTIPLY wrong: " x
           END-IF
           .