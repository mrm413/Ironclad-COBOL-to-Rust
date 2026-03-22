IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  dummy-1     PIC X(10).
       01  dummy-2     PIC X(10).
       01  dummy-3     PIC X(10).

       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN          SECTION.
       01  scr.
           03  PIC X(80) VALUE 'Enter "y" if the cursor is initially '-
               'located at the start of the rightmost'.
           03  LINE + 1, PIC X(80) VALUE 'field.'.
           03  LINE + 2, PIC X(10) TO dummy-1.
           03  COL + 2, PIC X(10) TO dummy-2.
           03  COL + 2, PIC X(10) TO dummy-3, INITIAL.
           03  success-field LINE + 2, PIC X, REQUIRED,
                                              USING success-flag.

       PROCEDURE       DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .