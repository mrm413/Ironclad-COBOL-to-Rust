IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  PIC X(80)
               VALUE 'Enter "y" if the string has a vertical line to '
               & 'its left:'.
           03  LINE + 1, COL 2, PIC X(10) VALUE 'Leftline' LEFTLINE.
           03  success-field LINE + 2, PIC X, REQUIRED,
                                              USING success-flag.

       PROCEDURE DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .