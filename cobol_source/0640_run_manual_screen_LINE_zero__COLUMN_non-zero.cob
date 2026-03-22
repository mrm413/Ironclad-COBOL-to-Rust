IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  LINE 1 VALUE 'Enter "y" if you see 123 on the line '-
               'below starting at column 1.'.
           03  LINE + 3 PIC X, REQUIRED USING success-flag.
           03  LINE 2 COL 3, VALUE '3'.
           03  LINE 1 COL 80 VALUE ' '.

       PROCEDURE        DIVISION.
           DISPLAY scr
           DISPLAY '1' LINE 0, COLUMN 1; '2'
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .