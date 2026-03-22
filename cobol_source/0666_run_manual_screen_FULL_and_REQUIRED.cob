IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(10).
       01  success-flag PIC X.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  PIC X(80)
               VALUE 'Enter "y" if you cannot continue without filling '
               & 'all of the below field:'.
           03  LINE + 1, PIC X(10), FULL, REQUIRED, TO dummy.
                    *> no initial value for success as we request input
           03  success-field LINE + 2, PIC X, REQUIRED, TO success-flag.

       PROCEDURE DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .