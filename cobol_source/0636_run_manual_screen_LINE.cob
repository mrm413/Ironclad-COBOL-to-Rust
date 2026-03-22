IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  LINE 1 VALUE 'Enter "y" if the numbers below correspond '
               & 'to their line number and are in the '.
           03  LINE 2 VALUE 'first column. (This is line 2.)'.
           03  LINE 3 VALUE '3'.
           03  LINE 4 VALUE '4'.
           03  LINE 5 VALUE '5'.
           03  group-1 LINE - 3.
               05  group-2 COL 5.
                   07  LINE PLUS 6 VALUE '8'.
                   07  LINE MINUS 2 VALUE '6'.
           03  group-3 LINE + 1.
               05 COL 1 VALUE '7'.
           03  LINE + 3 PIC X, REQUIRED USING success-flag.

       PROCEDURE        DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .