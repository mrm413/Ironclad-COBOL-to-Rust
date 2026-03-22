IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(10).
       01  success-flag PIC X.
           88  success  VALUE 'Y', 'y'.
       77  CBLACK       PIC 9(05) VALUE 1.
       77  CBLUE        PIC 9(05) VALUE 2.
       77  CGREEN       PIC 9(05) VALUE 3.
       77  CCYAN        PIC 9(05) VALUE 4.
       77  CRED         PIC 9(05) VALUE 5.
       77  CMAGENTA     PIC 9(05) VALUE 6.
       77  CYELLOW      PIC 9(05) VALUE 7.
       77  CWHITE       PIC 9(05) VALUE 8.

       SCREEN           SECTION.
       01  scr.
           03  PIC X(80)
               VALUE 'Enter "y" if the text below matches the colour '
               & 'of the background/text.'.
           03  LINE + 1, COL 1, PIC X(80)
               VALUE 'Note: the black text is on white background/the '
               & 'white background has black text'.
           03  LINE + 1, COL 1, PIC X(80)
               VALUE 'to make the text visible.'.

           03  LINE + 1.
             05  COL 1,   PIC X(08) VALUE 'Black'   COLOR CBLACK.
             05  COL + 2, PIC X(08) VALUE 'Blue'    COLOR CBLUE.
             05  COL + 2, PIC X(08) VALUE 'Green'   COLOR CGREEN.
             05  COL + 2, PIC X(08) VALUE 'Cyan'    COLOR CCYAN.
             05  COL + 2, PIC X(08) VALUE 'Red'     COLOR CRED.
             05  COL + 2, PIC X(08) VALUE 'Magenta' COLOR CMAGENTA.
             05  COL + 2, PIC X(15) VALUE 'Brown/Yellow'
                                                    COLOR CYELLOW.
             05  COL + 2, PIC X(08) VALUE 'White'   COLOR CWHITE.

       01  scr2.
           03  LINE 5.
             05  COL 1,   PIC X(08) VALUE 'Black'   BACKGROUND-COLOR 0
                                                    FOREGROUND-COLOR 7.
             05  COL + 2, PIC X(08) VALUE 'Blue'    BACKGROUND-COLOR 1.
             05  COL + 2, PIC X(08) VALUE 'Green'   BACKGROUND-COLOR 2.
             05  COL + 2, PIC X(08) VALUE 'Cyan'    BACKGROUND-COLOR 3.
             05  COL + 2, PIC X(08) VALUE 'Red'     BACKGROUND-COLOR 4.
             05  COL + 2, PIC X(08) VALUE 'Magenta' BACKGROUND-COLOR 5.
             05  COL + 2, PIC X(15) VALUE 'Brown/Yellow'
                                                    BACKGROUND-COLOR 6.
             05  COL + 2, PIC X(08) VALUE 'White'   BACKGROUND-COLOR 7
                                                    FOREGROUND-COLOR 0.

           03  success-field LINE + 2, COL 1, PIC X, REQUIRED,
               TO success-flag FROM 'Y'.

       PROCEDURE DIVISION.
           ADD  256 TO CBLACK
           DISPLAY scr
           ADD 1024 TO CBLACK, CBLUE, CGREEN, CCYAN,
                       CRED, CMAGENTA, CYELLOW, CWHITE
           DISPLAY scr2
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .