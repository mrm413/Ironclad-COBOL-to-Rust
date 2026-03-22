IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 RESULT        USAGE BINARY-LONG.
       PROCEDURE        DIVISION.

           MOVE FUNCTION TEST-NUMVAL-F ("+ 1")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 1  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F (" + 1")    TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 2  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("- 1")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 3  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F (" - 1")    TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 4  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("+- 1")    TO RESULT
           IF RESULT NOT = 2
              DISPLAY "Test 5  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1 +")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 6  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1 -")     TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 7  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1 +-")    TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 8  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1 -+")    TO RESULT
           IF RESULT NOT = 4
              DISPLAY "Test 9  fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("+ 1.1")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 10 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("- 1.1")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 11 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1 +")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 12 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1 -")   TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 13 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1   ")  TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 14 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1   ")  TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 15 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1 -CR") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 16 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1 E+1") TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 17 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1 E -1") TO RESULT
           IF RESULT NOT = 0
              DISPLAY "Test 18 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("1.1 EE") TO RESULT
           IF RESULT NOT = 6
              DISPLAY "Test 19 fail: " RESULT.

           MOVE FUNCTION TEST-NUMVAL-F ("+1.1 E001") TO RESULT
           IF RESULT NOT = 7
              DISPLAY "Test 20 fail: " RESULT.

           STOP RUN.