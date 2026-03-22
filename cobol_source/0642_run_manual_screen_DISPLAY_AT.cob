IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       01  screen-loc   PIC 9(6) VALUE 4004.

       SCREEN           SECTION.
       01  scr.
           03  VALUE 'Enter "y" if the numbers 1-3 are in a diagonal'-
               ' line from line 2, column 2.'.
           03  success-field PIC X, LINE 6, REQUIRED,
                                    USING success-flag.

       PROCEDURE DIVISION.
           DISPLAY '1' AT 0202
           DISPLAY '2' AT 003003
           DISPLAY '3' AT screen-loc
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .