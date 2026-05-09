IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-10      PIC X(10).
       PROCEDURE DIVISION.
           DISPLAY "Enter 'y' if pressing the ALT and RIGHT-ARROW keys"
               LINE 1 COLUMN 1.
           DISPLAY "at the last column does not exit the field."
               LINE 2 COLUMN 1.
           DISPLAY "But the RIGHT-ARROW without ALT does exit."
               LINE 3 COLUMN 1.

           MOVE "ABCDE" TO WS-X-10.
           ACCEPT WS-X-10
               LINE 5 COLUMN 1
               WITH
                   AUTO-SKIP
                   SIZE 5
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