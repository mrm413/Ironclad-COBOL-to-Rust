IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(10).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  PIC X(80)
               VALUE 'Enter "y" if text in the field below is replaced '
               & 'with asterisks:'.
           03  LINE + 1, PIC X(10) SECURE TO dummy, PROMPT CHARACTER
               "-".
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