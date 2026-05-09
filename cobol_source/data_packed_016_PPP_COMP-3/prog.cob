IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78 FENCE         VALUE x'ABBAAB'.
       01 FILLER.
         05 FENCE-A          PIC XXX VALUE FENCE.
         05 X-1  PIC 999PPP  COMP-6  VALUE 91000.
         05 FENCE-B          PIC XXX VALUE FENCE.
         05 X-2  PIC 999PPP  COMP-6  VALUE 92000.
         05 FENCE-C          PIC XXX VALUE FENCE.
         05 X-4  PIC VPPP999 COMP-6  VALUE 0.000128.
         05 FENCE-D          PIC XXX VALUE FENCE.
       01 FENCE-1            PIC XXX VALUE FENCE.
       01 D-1    PIC 999PPP  COMP-6  VALUE 95000.
       01 D-2    PIC 9999PP  COMP-6  VALUE 193000.
       01 FENCE-2            PIC XXX VALUE FENCE.
       01  WRK-DS-LS-1P17-1 PIC S9P(17) SIGN LEADING SEPARATE
           CHARACTER VALUE  -100000000000000000.
       01  WRK-AE-3  PIC XBXXX/XXX/XXX/XXX/XXXBXX.
       01  MOVE72    PICTURE 9(10) VALUE 3344556677.
       01  MOVE73    PICTURE X(5)BA(10)0X.
       01  GRP-AE-0002.
           05  AE-0002             PICTURE XX0XXBXXX.
       PROCEDURE        DIVISION.
           MOVE    3344556677 TO MOVE72.
           MOVE    MOVE72 TO MOVE73.
           IF MOVE73 NOT EQUAL TO "33445 56677     0 "
              DISPLAY "MOVE X-EDIT failed: " MOVE73 ".".
           MOVE 019823 TO AE-0002.
           IF GRP-AE-0002 NOT EQUAL TO "01098 23 "
              DISPLAY "MOVE AE-EDIT failed: " GRP-AE-0002 ".".
           MOVE WRK-DS-LS-1P17-1 TO WRK-AE-3.
           DISPLAY "MOVE 1P17: " WRK-DS-LS-1P17-1 " : "
                      LENGTH OF WRK-DS-LS-1P17-1 ".".
           DISPLAY "MOVE A-E : " WRK-AE-3 ".".
           IF WRK-AE-3 NOT EQUAL TO "1 000/000/000/000/000 00"
              DISPLAY "MOVE 1P17 TO A-E failed".
           DISPLAY "INIT X-1 : " X-1 " .".
           DISPLAY "INIT X-2 : " X-2 " .".
           DISPLAY "INIT X-4 : " X-4 " .".
           DISPLAY "INIT D-1 : " D-1 " .".
           MOVE D-1 TO X-2 X-1
           MOVE X-2 TO D-1.
           DISPLAY "MOVE X-1 : " X-1 " .".
           DISPLAY "MOVE X-2 : " X-2 " .".
           MOVE 0.000256 TO X-4
           DISPLAY "MOVE X-4 : " X-4 " .".
           DISPLAY "MOVE D-1 : " D-1 " .".
           MOVE D-2 TO X-2 X-1
           DISPLAY "MOVE X-1 : " X-1 ":" D-2 " .".
           DISPLAY "MOVE X-2 : " X-2 ":" D-2 " .".
           MOVE 98000   TO X-1.
           IF X-1 NOT = 98000
             DISPLAY "MOVE 98000 failed: " X-1.
           MOVE 98000   TO D-1
           IF D-1 NOT = 98000
             DISPLAY "MOVE 98000 failed: " D-1.
           ADD 1000 TO X-1
           IF X-1 NOT = 99000
             DISPLAY "+ 1000 failed: " X-1.
           SUBTRACT 4000 FROM X-1.
           IF X-1 NOT = 95000
             DISPLAY "- 4000 failed: " X-1.
           DIVIDE 3 INTO X-1.
           IF X-1 NOT = 31000
             DISPLAY "/ 3 failed: " X-1.
           MULTIPLY 2 BY X-1 GIVING X-1.
           IF X-1 NOT = 62000
             DISPLAY "* 2 failed: " X-1.

           IF FENCE-1 NOT = FENCE
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-A NOT = FENCE
             DISPLAY 'broken FENCE-A' UPON SYSERR.
           IF FENCE-B NOT = FENCE
             DISPLAY 'broken FENCE-B' UPON SYSERR.
           IF FENCE-C NOT = FENCE
             DISPLAY 'broken FENCE-C' UPON SYSERR.
           IF FENCE-D NOT = FENCE
             DISPLAY 'broken FENCE-D' UPON SYSERR.

           STOP RUN.