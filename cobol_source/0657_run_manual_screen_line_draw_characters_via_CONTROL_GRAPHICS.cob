[
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.
       
       77  LIN-START    PIC 99    COMP-5.
       77  LIN          PIC 99    COMP-5.

       01  scr1 PIC X(75)
               VALUE 'Enter "y" if you see line draw characters. '
               & 'The first set (single/double)'.
       01  scr2 PIC X(75)
               VALUE 'uses HIGHLIGHT, the second uses '
               & 'LOWLIGHT, BLINK and MAGENTA.'.

       01  graphcontrol PIC X(50) VALUE 'HIGH, GRAPHICS'.

       PROCEDURE DIVISION.
       testme.
           MOVE 2 TO LIN
           DISPLAY scr1 AT LINE LIN COL 2
           ADD  1 TO LIN
           DISPLAY scr2 AT LINE LIN COL 2
      *
           MOVE 5 TO LIN-START
           PERFORM dspcol
           MOVE 12 TO LIN-START
           MOVE "LOW BLINK FCOLOR=MAGENTA GRAPHICS" TO graphcontrol
           PERFORM dspcol
      *
           ACCEPT success-flag AT 1801 UPDATE REQUIRED

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1.

       dspcol.
      *    Single-line graphics
           MOVE LIN-START TO LIN
           DISPLAY "lqqqqwqqqqk" LINE LIN COL 05, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "x    x    x" LINE LIN COL 05, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "tqqqqnqqqqu" LINE LIN COL 05, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "x    x    x" LINE LIN COL 05, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "mqqqqvqqqqj" LINE LIN COL 05, CONTROL graphcontrol.
           ADD  1 TO LIN
      *    Double-line graphics
           MOVE LIN-START TO LIN
           DISPLAY "LQQQQWQQQQK" LINE LIN COL 20, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "X    X    X" LINE LIN COL 20, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "TQQQQNQQQQU" LINE LIN COL 20, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "X    X    X" LINE LIN COL 20, CONTROL graphcontrol.
           ADD  1 TO LIN
           DISPLAY "MQQQQVQQQQJ" LINE LIN COL 20, CONTROL graphcontrol.
]