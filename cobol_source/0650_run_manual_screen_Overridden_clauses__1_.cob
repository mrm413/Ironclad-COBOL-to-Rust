IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(5).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
       03  VALUE 'Enter "y" if the numbers below correspond to their'
           & ' column number and all on'.
           03  LINE 2 VALUE 'lines 3 and 4.'.
           03  LINE 3 VALUE '123456789'.
           03  LINE 4 VALUE '  34'.
           03  FILLER LINE + 6.
               05 COL 3.
                   07  COL 1.
                       09  LINE 4 VALUE '1'.
                       09  VALUE '2'.
               05  LINE + 1, COL + 2.
                   07  LINE 4, COL + 1, VALUE '5'.
           03  LINE 6 PIC X, REQUIRED, USING success-flag.

       PROCEDURE        DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .