IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(20).
       PROCEDURE DIVISION.
           DISPLAY "Enter 'y' if each press of the DELETE key deletes"
               LINE 1 COLUMN 1.
           DISPLAY "the cursor character and moves the remaining"
               LINE 2 COLUMN 1.
           DISPLAY "characters one space to the left.  And the cursor"
               LINE 3 COLUMN 1.
           DISPLAY "does not move."
               LINE 4 COLUMN 1.

           MOVE "ABCD      " TO WS-X-20.
           ACCEPT WS-X-20
               LINE 6 COLUMN 1
               WITH
                   AUTO-SKIP
                   SIZE 10
                   UPDATE.

           ACCEPT SUCCESS-FLAG
               LINE 8 COLUMN 1
               WITH UPDATE.

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .