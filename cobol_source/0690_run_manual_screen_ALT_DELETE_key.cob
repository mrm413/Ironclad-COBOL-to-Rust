IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(20).
       PROCEDURE DIVISION.
           DISPLAY "Enter 'y' if pressing the ALT and DELETE keys"
               LINE 1 COLUMN 1.
           DISPLAY "deletes all characters from the cursor to the end"
               LINE 2 COLUMN 1.
           DISPLAY "of the field.  And the cursor does not move."
               LINE 3 COLUMN 1.

           MOVE "ABCD      " TO WS-X-20.
           ACCEPT WS-X-20
               LINE 5 COLUMN 1
               WITH
                   AUTO-SKIP
                   SIZE 10
                   UPDATE.

           ACCEPT SUCCESS-FLAG
               LINE 7 COLUMN 1
               WITH UPDATE.

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .