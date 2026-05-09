IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  LINE 1 VALUE 'Enter "y" if the word below starts at line'
               & ' 3, column 3.'.
           03  LINE + 4 PIC X, REQUIRED USING success-flag.

       PROCEDURE        DIVISION.
           DISPLAY scr
           DISPLAY LOW-VALUES AT LINE 3, COL 3; 'Hello!'
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .