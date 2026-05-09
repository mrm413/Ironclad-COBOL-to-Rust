IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       01  num-1		PIC 9(5) VALUE 12345.
       01  num-2        PIC X(10) VALUE '12345'.
       01  num-3        PIC 9(4) VALUE 1234.

       01  four         PIC 9 VALUE 4.

       PROCEDURE        DIVISION.
           DISPLAY 'Enter "y" if you see exactly four rows of 1234, all'
               & ' aligned.' LINE 1

           DISPLAY num-1 LINE 3 COL 3, SIZE 4;
               num-2 LINE 4 COL 3, SIZE four;
               num-3 LINE 5 COL 3, SIZE 8;
               '1234' LINE 6 COL 3, SIZE ZERO

           ACCEPT success-flag LINE 8, REQUIRED UPDATE

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .