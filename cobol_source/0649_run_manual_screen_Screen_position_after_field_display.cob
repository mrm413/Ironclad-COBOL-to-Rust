IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  VALUE 'Enter "y" if this sentence starts at line 1,'-
               ' column 1:'.
           03  success-field PIC X, COL + 2, REQUIRED,
                                             USING success-flag.

       PROCEDURE DIVISION.
           DISPLAY 'ignore this' AT LINE 4 COL 4
           DISPLAY scr
           ACCEPT success-field

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .