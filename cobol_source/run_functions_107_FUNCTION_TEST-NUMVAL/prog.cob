IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 RESULT        USAGE BINARY-LONG.
       01 EMPTY.
        03 PIC X OCCURS 0 TO 5 DEPENDING ON RESULT.
       PROCEDURE        DIVISION.
           MOVE FUNCTION TEST-NUMVAL ("+ 1")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 1  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL (" + 1")    TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 2  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("- 1")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 3  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL (" - 1")    TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 4  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("+- 1")    TO RESULT
           IF RESULT NOT = 2
              DISPLAY "Test 5  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1 +")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 6  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1 -")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 7  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1 +-")    TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 8  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1 -+")    TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 9  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("+ 1.1")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 10 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("- 1.1")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 11 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 +")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 12 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 -")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 13 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 CR")  TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 14 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 DB")  TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 15 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 -CR") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 16 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 +DB") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 17 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 CDB") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 18 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("+1.1 CR") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 19 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("+      ") TO RESULT
           IF RESULT NOT = 8
              DISPLAY "Test 20 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("  0.   ") TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 21 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("  .0   ") TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 22 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("  . 0") TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 23 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("  0 .") TO RESULT
           IF RESULT NOT = 5
              DISPLAY "Test 24 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("   0+0") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 25 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("   0+  0") TO RESULT
           IF RESULT NOT = 8
              DISPLAY "Test 26 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("1.1 D")  TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 27 fail: " RESULT.

      *    MOVE FUNCTION TEST-NUMVAL ("") TO RESULT
           MOVE 0 TO RESULT
           MOVE FUNCTION TEST-NUMVAL (EMPTY) TO RESULT
           IF RESULT NOT = 1
              DISPLAY "Test 28 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("   ") TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 29 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("  .") TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 30 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL ("    ") TO RESULT
           IF RESULT NOT = 5
              DISPLAY "Test 31 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL (" 1  T") TO RESULT
           IF RESULT NOT = 5
              DISPLAY "Test 32 fail: " RESULT.

           STOP RUN.