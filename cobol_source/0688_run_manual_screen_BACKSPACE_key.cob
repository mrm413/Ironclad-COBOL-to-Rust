IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
       CURSOR IS cur-pos.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  cur-pos      pic 9(06).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(20).
       PROCEDURE DIVISION.
           DISPLAY "Enter 'y' if each press of the BACKSPACE key"
               LINE 1 COLUMN 1.
           DISPLAY "deletes the character to the left and moves the"
               LINE 2 COLUMN 1.
           DISPLAY "cursor and remaining characters one space to the"
               LINE 3 COLUMN 1.
           DISPLAY "left."
               LINE 4 COLUMN 1.

           MOVE "ABCD      " TO WS-X-20.
           MOVE 006002       TO cur-pos.
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