IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  LINE 1 VALUE 'Enter "y" if you can see lorem ipsum '
               & 'filler text.'.
           03  LINE 3 COL 3 VALUE 'Lorem ipsum dolor sit amet,'
               & ' consectetur ad ipiscing elit.'.

       01  success-scr.
           03 LINE 3, BLANK LINE, PIC X, REQUIRED, USING success-flag.

       PROCEDURE        DIVISION.
           DISPLAY scr
           ACCEPT success-scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .