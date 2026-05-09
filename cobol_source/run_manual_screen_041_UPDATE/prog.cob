IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  n-str        PIC X(12) VALUE SPACES.
       01  success-flag PIC X.
           88  success VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03  VALUE 'Enter "y" if the entry field below is filled with'
                 & ' N''s'.
           03  n-field, LINE + 1, PIC X(12) USING n-str.
           03  success-field, LINE + 2, PIC X, REQUIRED,
               TO success-flag, FROM 'Y'.

       PROCEDURE        DIVISION.
           DISPLAY scr
           MOVE ALL 'N' TO n-str
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .