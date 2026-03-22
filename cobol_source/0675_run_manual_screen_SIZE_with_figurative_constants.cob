IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       PROCEDURE        DIVISION.
           DISPLAY 'Enter "y" if you see exactly three rows of quotes, '
               & 'zeroes and ''abc'',', LINE 1
           DISPLAY '8 characters long, all aligned.', LINE 2

           DISPLAY QUOTES LINE 4 COL 3, SIZE 8;
               ZEROES LINE 5 COL 3, SIZE 8;
               ALL 'abc' LINE 6 COL 3, SIZE 8

           DISPLAY '123456789' LINE 7 COL 3
           DISPLAY SPACE LINE 7 COL 3, SIZE 9

           ACCEPT success-flag LINE 8, REQUIRED UPDATE

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .