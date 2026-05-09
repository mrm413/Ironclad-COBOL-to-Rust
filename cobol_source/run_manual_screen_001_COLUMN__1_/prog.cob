IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(5).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  VALUE 'Enter "y" if the numbers below correspond to '
               & 'their column number.'.
           03  LINE 2 VALUE '123456789'.
           03  LINE 3 COLUMN 2.
               05  COL 1 VALUE '1'.
               05  COL 5 VALUE '5'.
               05  COL MINUS 2 VALUE '3'.
               05  COL PLUS 1 VALUE '4'.
               05  group-1 LINE 3.
                   07  VALUE '2'.
                   07  group-2 COLUMN + 4.
                       09  group-3.
                           11 COL + 0 VALUE '6'.
               05  COLUMN + 1, VALUE '7'.
           03  LINE 5 PIC X, REQUIRED, USING success-flag.

       PROCEDURE        DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .