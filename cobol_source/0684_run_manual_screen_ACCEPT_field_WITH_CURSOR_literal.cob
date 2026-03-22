IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(20).
       PROCEDURE DIVISION.
       testme.
           set environment 'COB_SCREEN_EXCEPTIONS' to 'TRUE'
           set environment 'COB_SCREEN_ESC'        to 'TRUE'

           DISPLAY "If the cursor below is positioned at the 'C'"
               LINE 1 COLUMN 1.
           DISPLAY "(third column in field) below, then press ENTER."
               LINE 2 COLUMN 1.

           MOVE "ABCDEFG   " TO WS-X-20.
           ACCEPT WS-X-20
               LINE 4 COLUMN 2
               WITH
                   AUTO-SKIP
                   SIZE 10
                   CURSOR 3
                   UPDATE.

           IF COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .