[
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

      * ACU: "=", names only
       77  CBLACK       PIC X(99) VALUE "FCOLOR=BLACK, "
                                      & "BCOLOR=WHITE,".
       77  CBLUE        PIC X(99) VALUE "FCOLOR=BLUE  , "
                                      & "BCOLOR=BLACK,".
      * MF: "IS" or "=" or " ", also extended color numbers
       77  CGREEN       PIC X(99) VALUE "FCOLOR IS GREEN, "
                                      & "BCOLOR BLACK,".
       77  CCYAN        PIC X(99) VALUE "FCOLOR  =CYAN, "
                                      & "BCOLOR= BLACK, ".
       77  CRED         PIC X(99) VALUE "FCOLOR=RED "
                                      & "BCOLOR=BLACK, ".
       77  CMAGENTA     PIC X(99) VALUE "FCOLOR=MAGENTA, "
                                      & "BCOLOR=BLACK,".
       77  CYELLOW      PIC X(99) VALUE "FCOLOR = 6, "
                                      & "BCOLOR=BLACK,".
       77  CWHITE       PIC X(99) VALUE "FCOLOR=WHITE, "
                                      & "BCOLOR=BLACK, ".
       
       77  LIN          PIC 99    COMP-5.

       01  scr1 PIC X(75)
               VALUE 'Enter "y" if the text below matches the colour '
               & 'of the background/text.'.
       01  scr2 PIC X(75)
               VALUE 'Note: the black text is on white background/the '
               & 'white background has black'.
       01  scr3 PIC X(75)
               VALUE 'text to make the text visible.'
               & '  [This text *may* has "surrounding lines".]'.
       01  scr8 PIC X(75)
               VALUE 'following lines should be identical but '
               & 'highlighted for the first line'.
       01  scr9 PIC X(75)
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
           MOVE 2 TO LIN
           DISPLAY scr1 ( 1:1) AT LINE LIN COL 2
              CONTROL "LEFTLINE OVERLINE"
           DISPLAY scr1 ( 2:)  AT LINE LIN COL 2 + 1
              CONTROL "OVERLINE"
           DISPLAY scr1 (75:)  AT LINE LIN COL 2 + 75
              CONTROL "OVERLINE  RIGHTLINE"
           ADD  1 TO LIN
           DISPLAY scr2 ( 1:1) AT LINE LIN COL 2
              CONTROL "LEFTLINE"
           DISPLAY scr2 ( 2:)  AT LINE LIN COL 2 + 1
           DISPLAY scr2 (75:)  AT LINE LIN COL 2 + 75
              CONTROL "RIGHTLINE"
           ADD  1 TO LIN
           DISPLAY scr3 ( 1:1) AT LINE LIN COL 2
              CONTROL "LEFTLINE UNDERLINE"
           DISPLAY scr3 ( 2:)  AT LINE LIN COL 2 + 1
              CONTROL "UNDERLINE"
           DISPLAY scr3 (75:)  AT LINE LIN COL 2 + 75
              CONTROL "UNDERLINE  RIGHTLINE"
      *
           ADD  2 TO LIN
           PERFORM dspcol
           MOVE "REVERSE," TO 
               CBLACK (40:), CBLUE (40:), CGREEN (40:), CCYAN (40:),
               CRED (40:), CMAGENTA (40:), CYELLOW (40:), CWHITE (40:)
           ADD  1 TO LIN
           PERFORM dspcol
      *
           INSPECT CRED REPLACING ALL "=" BY " "
           ADD  2 TO LIN
           DISPLAY scr8 AT LINE LIN COL 2
           ADD  1 TO LIN
           DISPLAY scr9 AT LINE LIN COL 2
      *
           MOVE "HIGHLIGHT,NO REVERSE" TO 
               CBLACK (50:), CBLUE (50:), CGREEN (50:), CCYAN (50:),
               CRED (50:), CMAGENTA (50:), CYELLOW (50:), CWHITE (50:)
           ADD  1 TO LIN
           PERFORM dspcol
           MOVE "NO HIGH, BLINK" TO 
               CBLACK (60:), CBLUE (60:), CGREEN (60:), CCYAN (60:),
               CRED (60:), CMAGENTA (60:), CYELLOW (60:), CWHITE (60:)
           MOVE 12 TO LIN
           PERFORM dspcol
      *
           ACCEPT success-flag AT 1801 UPDATE REQUIRED

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1.

       dspcol.
           DISPLAY scrblack LINE LIN COL 1,  CONTROL CBLACK.
           DISPLAY scrblue  LINE LIN COL 10, CONTROL CBLUE.
           DISPLAY scrgreen LINE LIN COL 19, CONTROL CGREEN.
           DISPLAY scrcyan  LINE LIN COL 28, CONTROL CCYAN.
           DISPLAY scrred   LINE LIN COL 37, CONTROL CRED.
           DISPLAY scrmaggy LINE LIN COL 46, CONTROL CMAGENTA.
           DISPLAY scryell  LINE LIN COL 55, CONTROL CYELLOW.
           DISPLAY scrwhite LINE LIN COL 70, CONTROL CWHITE.
]