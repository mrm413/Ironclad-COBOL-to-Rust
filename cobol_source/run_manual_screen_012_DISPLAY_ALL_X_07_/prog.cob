IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  VALUE 'Enter "y" if you heard a beep:'.
           03  success-field PIC X, COL + 2, REQUIRED, TO success-flag
                                                       FROM 'Y'.
       01  scr2.
           03  LINE 4 VALUE 'system beep may be turned off ' &
                             'on this system.'.
           03  LINE 5 VALUE 'Retesting with COB_BELL=FLASH...'.
           03  LINE + 2
               VALUE 'Enter "y" if you''ve seen your terminal flash'.
           03  success-field PIC X, COL + 2, REQUIRED, TO success-flag
                                                       FROM 'Y'.

       PROCEDURE DIVISION.
           DISPLAY scr
           DISPLAY ALL X'07' UPON CRT
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           END-IF

           SET ENVIRONMENT 'COB_BELL' TO 'FLASH'
           CALL 'C$SLEEP' USING '1'

           DISPLAY scr2
           DISPLAY ALL X'07' UPON CRT
           ACCEPT scr2

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .