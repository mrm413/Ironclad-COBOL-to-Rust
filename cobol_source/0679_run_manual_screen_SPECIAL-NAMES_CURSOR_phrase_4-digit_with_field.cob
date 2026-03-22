IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
       CURSOR IS cur-pos.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  cur-pos      pic 9(04).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       01  ws-x-20      PIC X(20).
       PROCEDURE DIVISION.
       testme.
           set environment 'COB_SCREEN_EXCEPTIONS' to 'TRUE'
           set environment 'COB_SCREEN_ESC'        to 'TRUE'

           DISPLAY "If the cursor below is positioned at the 'C'"
               LINE 1 COLUMN 1.
           DISPLAY "(third column) below, then position it at the"
               LINE 2 COLUMN 1.
           DISPLAY "'E' (fifth column) and press ENTER."
               LINE 3 COLUMN 1.

           MOVE "ABCDEFG   " TO WS-X-20.
           MOVE 0503         TO cur-pos.
           ACCEPT WS-X-20
               LINE 5 COLUMN 1
               WITH
                   AUTO-SKIP
                   SIZE 10
                   UPDATE.

           IF cur-pos = 0505 AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .