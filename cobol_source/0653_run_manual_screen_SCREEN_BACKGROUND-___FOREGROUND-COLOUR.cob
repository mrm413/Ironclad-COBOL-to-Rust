IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(10).
       01  success-flag PIC X.
           88  success  VALUE 'Y', 'y'.

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
             05  COL 1,   PIC X(08) VALUE 'Black'   FOREGROUND-COLOR 0
                                                    BACKGROUND-COLOR 7.
             05  COL + 2, PIC X(08) VALUE 'Blue'    FOREGROUND-COLOR 1.
             05  COL + 2, PIC X(08) VALUE 'Green'   FOREGROUND-COLOR 2.
             05  COL + 2, PIC X(08) VALUE 'Cyan'    FOREGROUND-COLOR 3.
             05  COL + 2, PIC X(08) VALUE 'Red'     FOREGROUND-COLOR 4.
             05  COL + 2, PIC X(08) VALUE 'Magenta' FOREGROUND-COLOR 5.
             05  COL + 2, PIC X(15) VALUE 'Brown/Yellow'
                                                    FOREGROUND-COLOR 6.
             05  COL + 2, PIC X(08) VALUE 'White'   FOREGROUND-COLOR 7.

           03  LINE + 1.
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

           03  LINE + 2.
           03  PIC X(80)
               VALUE 'The following is the same as above, '
               & 'with "extended" attributes set;'.
           03  LINE + 1, COL 1, PIC X(80)
               VALUE 'this should have the same effect as otherwise '
               & 'highlighted for the first line'.
           03  LINE + 1, COL 1, PIC X(80)
               VALUE 'and blinking for the second one.'.

           03  LINE + 1.
             05  COL 1,   PIC X(08) VALUE 'Black'   FOREGROUND-COLOR 8
                                                    BACKGROUND-COLOR 0.
             05  COL + 2, PIC X(08) VALUE 'Blue'    FOREGROUND-COLOR 9.
             05  COL + 2, PIC X(08) VALUE 'Green'   FOREGROUND-COLOR 10.
             05  COL + 2, PIC X(08) VALUE 'Cyan'    FOREGROUND-COLOR 11.
             05  COL + 2, PIC X(08) VALUE 'Red'     FOREGROUND-COLOR 12.
             05  COL + 2, PIC X(08) VALUE 'Magenta' FOREGROUND-COLOR 13.
             05  COL + 2, PIC X(15) VALUE 'Brown/Yellow'
                                                    FOREGROUND-COLOR 14.
             05  COL + 2, PIC X(08) VALUE 'White'   FOREGROUND-COLOR 15.

           03  LINE + 1.
             05  COL 1,   PIC X(08) VALUE 'Black'   BACKGROUND-COLOR 8
                                                    FOREGROUND-COLOR 15.
             05  COL + 2, PIC X(08) VALUE 'Blue'    BACKGROUND-COLOR 9.
             05  COL + 2, PIC X(08) VALUE 'Green'   BACKGROUND-COLOR 10.
             05  COL + 2, PIC X(08) VALUE 'Cyan'    BACKGROUND-COLOR 11.
             05  COL + 2, PIC X(08) VALUE 'Red'     BACKGROUND-COLOR 12.
             05  COL + 2, PIC X(08) VALUE 'Magenta' BACKGROUND-COLOR 13.
             05  COL + 2, PIC X(15) VALUE 'Brown/Yellow'
                                                    BACKGROUND-COLOR 14.
             05  COL + 2, PIC X(08) VALUE 'White'   BACKGROUND-COLOR 15
                                                    FOREGROUND-COLOR 8.

           03  success-field LINE + 2, COL 1, PIC X, REQUIRED,
               TO success-flag FROM 'Y'.

       PROCEDURE DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .