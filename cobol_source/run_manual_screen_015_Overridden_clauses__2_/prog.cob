IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(5).
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  VALUE 'Enter "y" if the word below is not dim and has'
               & ' black background.'.
           03  LINE + 1, LOWLIGHT BACKGROUND-COLOR 3.
               05  HIGHLIGHT BACKGROUND-COLOR 0.
                   07 VALUE 'Highlight'.
           03  LINE + 2, PIC X USING success-flag.

       PROCEDURE        DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .