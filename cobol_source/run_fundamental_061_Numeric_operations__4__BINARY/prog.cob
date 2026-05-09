IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  FIELD        PIC S9(1)V9(1) COMP.
       01  FELD2        PIC S9(5)V9(5) COMP.
       01  FELD3        PIC 9(1)V9(1)  COMP.
       01  FELD4        PIC S9(1)      COMP.
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.

       PROCEDURE        DIVISION.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 20000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
           MOVE 0.2 TO FIELD
           ADD 1 TO FIELD
           IF FIELD  NOT = 1.2
              DISPLAY "Test  1 " FIELD.

           MOVE 0.2 TO FIELD
           ADD -1 TO FIELD
           IF FIELD  NOT = -0.8
              DISPLAY "Test  2 " FIELD.

           MOVE -0.2 TO FIELD
           ADD 1 TO FIELD
           IF FIELD  NOT = 0.8
              DISPLAY "Test  3 " FIELD.

           MOVE -0.2 TO FIELD
           ADD -1 TO FIELD
           IF FIELD  NOT = -1.2
              DISPLAY "Test  4 " FIELD.

           MOVE 0.2 TO FIELD
           SUBTRACT 1 FROM FIELD
           IF FIELD  NOT = -0.8
              DISPLAY "Test  5 " FIELD.

           MOVE 0.2 TO FIELD
           SUBTRACT -1 FROM FIELD
           IF FIELD  NOT = 1.2
              DISPLAY "Test  6 " FIELD.

           MOVE -0.2 TO FIELD
           SUBTRACT 1 FROM FIELD
           IF FIELD  NOT = -1.2
              DISPLAY "Test  7 " FIELD.

           MOVE -0.2 TO FIELD
           SUBTRACT -1 FROM FIELD
           IF FIELD  NOT = 0.8
              DISPLAY "Test  8 " FIELD.

           MOVE 0.2 TO FELD2
           ADD 1 TO FELD2
           IF FELD2  NOT = 1.2
              DISPLAY "Test  9 " FELD2.

           MOVE 0.2 TO FELD2
           ADD -1 TO FELD2
           IF FELD2  NOT = -0.8
              DISPLAY "Test 10 " FELD2.

           MOVE -0.2 TO FELD2
           ADD 1 TO FELD2
           IF FELD2  NOT = 0.8
              DISPLAY "Test 11 " FELD2.

           MOVE -0.2 TO FELD2
           ADD -1 TO FELD2
           IF FELD2  NOT = -1.2
              DISPLAY "Test 12 " FELD2.

           MOVE 0.2 TO FELD2
           SUBTRACT 1 FROM FELD2
           IF FELD2  NOT = -0.8
              DISPLAY "Test 13 " FELD2.

           MOVE 0.2 TO FELD2
           SUBTRACT -1 FROM FELD2
           IF FELD2  NOT = 1.2
              DISPLAY "Test 14 " FELD2.

           MOVE -0.2 TO FELD2
           SUBTRACT 1 FROM FELD2
           IF FELD2  NOT = -1.2
              DISPLAY "Test 15 " FELD2.

           MOVE -0.2 TO FELD2
           SUBTRACT -1 FROM FELD2
           IF FELD2  NOT = 0.8
              DISPLAY "Test 16 " FELD2.

           MOVE 0.2 TO FELD3
           ADD 1 TO FELD3
           IF FELD3  NOT = 1.2
              DISPLAY "Test 17 " FELD3.

           MOVE 0.2 TO FELD3
           ADD -1 TO FELD3
           IF FELD3  NOT = 0.8
              DISPLAY "Test 18 " FELD3.

           MOVE -0.2 TO FELD3
           ADD 1 TO FELD3
           IF FELD3  NOT = 1.2
              DISPLAY "Test 19 " FELD3.

           MOVE -0.2 TO FELD3
           ADD -1 TO FELD3
           IF FELD3  NOT = 0.8
              DISPLAY "Test 20 " FELD3.

           MOVE 0.2 TO FELD3
           SUBTRACT 1 FROM FELD3
           IF FELD3  NOT = 0.8
              DISPLAY "Test 21 " FELD3.

           MOVE 0.2 TO FELD3
           SUBTRACT -1 FROM FELD3
           IF FELD3  NOT = 1.2
              DISPLAY "Test 22 " FELD3.

           MOVE -0.2 TO FELD3
           SUBTRACT 1 FROM FELD3
           IF FELD3  NOT = 0.8
              DISPLAY "Test 23 " FELD3.

           MOVE -0.2 TO FELD3
           SUBTRACT -1 FROM FELD3
           IF FELD3  NOT = 1.2
              DISPLAY "Test 24 " FELD3.

           MOVE 2 TO FELD4
           ADD 1 TO FELD4
           IF FELD4  NOT = 3
              DISPLAY "Test 25 " FELD4.

           MOVE 2 TO FELD4
           ADD -1 TO FELD4
           IF FELD4  NOT = 1
              DISPLAY "Test 26 " FELD4.

           MOVE -2 TO FELD4
           ADD 1 TO FELD4
           IF FELD4  NOT = -1
              DISPLAY "Test 27 " FELD4.

           MOVE -2 TO FELD4
           ADD -1 TO FELD4
           IF FELD4  NOT = -3
              DISPLAY "Test 28 " FELD4.

           MOVE 2 TO FELD4
           SUBTRACT 1 FROM FELD4
           IF FELD4  NOT = 1
              DISPLAY "Test 29 " FELD4.

           MOVE 2 TO FELD4
           SUBTRACT -1 FROM FELD4
           IF FELD4  NOT = 3
              DISPLAY "Test 30 " FELD4.

           MOVE -2 TO FELD4
           SUBTRACT 1 FROM FELD4
           IF FELD4  NOT = -3
              DISPLAY "Test 31 " FELD4.

           MOVE -2 TO FELD4
           SUBTRACT -1 FROM FELD4
           IF FELD4  NOT = -1
              DISPLAY "Test 32 " FELD4.

           MOVE 1 TO FELD4
           ADD 2 TO FELD4
           IF FELD4  NOT = 3
              DISPLAY "Test 33 " FELD4.

           MOVE 1 TO FELD4
           ADD -2 TO FELD4
           IF FELD4  NOT = -1
              DISPLAY "Test 34 " FELD4.

           MOVE -1 TO FELD4
           ADD 2 TO FELD4
           IF FELD4  NOT = 1
              DISPLAY "Test 35 " FELD4.

           MOVE -1 TO FELD4
           ADD -2 TO FELD4
           IF FELD4  NOT = -3
              DISPLAY "Test 36 " FELD4.

           MOVE 1 TO FELD4
           SUBTRACT 2 FROM FELD4
           IF FELD4  NOT = -1
              DISPLAY "Test 37 " FELD4.

           MOVE 1 TO FELD4
           SUBTRACT -2 FROM FELD4
           IF FELD4  NOT = 3
              DISPLAY "Test 38 " FELD4.

           MOVE -1 TO FELD4
           SUBTRACT 2 FROM FELD4
           IF FELD4  NOT = -3
              DISPLAY "Test 39 " FELD4.

           MOVE -1 TO FELD4
           SUBTRACT -2 FROM FELD4
           IF FELD4  NOT = 1
              DISPLAY "Test 40 " FELD4.