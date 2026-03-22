IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       77  CBLACK       PIC 9(05) COMP-5 VALUE 1.
       77  CBLUE        PIC 9(05) COMP-5 VALUE 2.
       77  CGREEN       PIC 9(05) COMP-5 VALUE 3.
       77  CCYAN        PIC 9(05) COMP-5 VALUE 4.
       77  CRED         PIC 9(05) COMP-5 VALUE 5.
       77  CMAGENTA     PIC 9(05) COMP-5 VALUE 6.
       77  CYELLOW      PIC 9(05) COMP-5 VALUE 7.
       77  CWHITE       PIC 9(05) COMP-5 VALUE 8.
       
       77  LIN          PIC 99    COMP-5.

       01  scr1 PIC X(80)
               VALUE 'Enter "y" if the text below matches the colour '
               & 'of the background/text.'.
       01  scr2 PIC X(80)
               VALUE 'Note: the black text is on white background/the '
               & 'white background has black text'.
       01  scr3 PIC X(80)
               VALUE 'to make the text visible.'.
       01  scr8 PIC X(80)
               VALUE 'following lines should be identical but '
               & 'highlighted for the first line'.
       01  scr9 PIC X(80)
               VALUE 'and blinking for the second one.'.

       01  scrblack PIC X(08) VALUE 'Black'.
       01  scrblue  PIC X(08) VALUE 'Blue'.
       01  scrgreen PIC X(08) VALUE 'Green'.
       01  scrcyan  PIC X(08) VALUE 'Cyan'.
       01  scrred   PIC X(08) VALUE 'Red'.
       01  scrmaggy PIC X(08) VALUE 'Magenta'.
       01  scryell  PIC X(14) VALUE 'Brown/Yellow'.
       01  scrwhite PIC X(08) VALUE 'White'.

       PROCEDURE DIVISION.
       testme.
           ADD  256 TO CBLACK
           DISPLAY scr1 AT 0102
           DISPLAY scr2 AT 0202
           DISPLAY scr3 AT 0303
           MOVE 5 TO LIN
           PERFORM dspcol
           ADD 1024 TO CBLACK, CBLUE, CGREEN, CCYAN,
                       CRED, CMAGENTA, CYELLOW, CWHITE
           MOVE 6 TO LIN
           PERFORM dspcol
           SUBTRACT 1024 FROM CBLACK, CBLUE, CGREEN, CCYAN,
                       CRED, CMAGENTA, CYELLOW, CWHITE
      *
           DISPLAY scr8 AT 0802
           DISPLAY scr9 AT 0903
           ADD 4096 TO CBLACK, CBLUE, CGREEN, CCYAN,
                       CRED, CMAGENTA, CYELLOW, CWHITE
           MOVE 11 TO LIN
           PERFORM dspcol
           SUBTRACT 4096 FROM CBLACK, CBLUE, CGREEN, CCYAN,
                       CRED, CMAGENTA, CYELLOW, CWHITE
           ADD 1024, 16384 TO CBLACK, CBLUE, CGREEN, CCYAN,
                       CRED, CMAGENTA, CYELLOW, CWHITE
           MOVE 12 TO LIN
           PERFORM dspcol
      *
           ACCEPT success-flag AT 1401 UPDATE REQUIRED

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1.

       dspcol.
           DISPLAY scrblack LINE LIN COL 1,  COLOR CBLACK.
           DISPLAY scrblue  LINE LIN COL 11, COLOR CBLUE.
           DISPLAY scrgreen LINE LIN COL 21, COLOR CGREEN.
           DISPLAY scrcyan  LINE LIN COL 31, COLOR CCYAN.
           DISPLAY scrred   LINE LIN COL 41, COLOR CRED.
           DISPLAY scrmaggy LINE LIN COL 51, COLOR CMAGENTA.
           DISPLAY scryell  LINE LIN COL 61, COLOR CYELLOW.
           DISPLAY scrwhite LINE LIN COL 77, COLOR CWHITE.