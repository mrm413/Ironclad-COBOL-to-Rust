IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  cur-pos      pic 9(04).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(10).
       PROCEDURE DIVISION.
       testme.
           set environment 'COB_SCREEN_EXCEPTIONS' to 'TRUE'
           set environment 'COB_SCREEN_ESC'        to 'TRUE'

           DISPLAY "If the cursor below is positioned at the last"
               LINE 1 COLUMN 1.
           DISPLAY "column in the field below, then position it at"
               LINE 2 COLUMN 1.
           DISPLAY "the 'C' (third column) and press ENTER."
               LINE 3 COLUMN 1.

           MOVE "ABCDEFGHIJ" TO WS-X-20.
           MOVE 0012         TO cur-pos.
           ACCEPT WS-X-20
               LINE 5 COLUMN 3
               WITH
                   AUTO-SKIP
                   SIZE 10
                   CURSOR cur-pos
                   UPDATE.

           IF cur-pos = 0003 AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .