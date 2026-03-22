IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(20).
       PROCEDURE DIVISION.
           DISPLAY "Enter 'y' if multiple presses of the INSERT key"
               LINE 1 COLUMN 1.
           DISPLAY "go back and forth between"
               LINE 2 COLUMN 1.
           DISPLAY "Insert Mode ON (characters move to the right)"
               LINE 3 COLUMN 1.
           DISPLAY "and Insert Mode OFF (characters type over)."
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