IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  PIC X(80)
               VALUE 'Enter "y" if the background and foreground '
               & 'colours of the string below have'.
           03  LINE + 1, PIC X(80) VALUE 'swapped:'.
           03  LINE + 1, PIC X(20) VALUE 'Reversed colours'
               REVERSE-VIDEO.
           03  success-field LINE + 2, PIC X USING success-flag.

       PROCEDURE DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .