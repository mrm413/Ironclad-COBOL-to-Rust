IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  FIELD        PIC S9(1)V9(1) COMP-3.
       01  FELD2        PIC S9(5)V9(5) COMP-3.
       01  FELD3        PIC 9(1)V9(1)  COMP-3.
       01  FELD4        PIC S9(1)      COMP-3.
       01  FELD4b       PIC S9(4)      COMP-3.
       01  FELD5        PIC 9(9)v9(9)  COMP-3.
       01  FELD5b       PIC 9(18)      COMP-3.
       01  FELD6        PIC 9(8)v9(20) COMP-3.
       01  FELD6b       PIC s9(8)9(20)  COMP-3.
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

      *    unsigned, so ends as 0.2
           MOVE -0.2 TO FELD3
           ADD 1 TO FELD3
           IF FELD3  NOT = 1.2
              DISPLAY "Test 19 " FELD3.

      *    unsigned, so ends as 0.2 - 1 -> -0.8 -> 0.8
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

           MOVE -2 TO FELD4b
           ADD -1 TO FELD4b
           IF FELD4b  NOT = -3
              DISPLAY "Test 28b " FELD4b.

           MOVE 2 TO FELD4
           SUBTRACT 1 FROM FELD4
           IF FELD4  NOT = 1
              DISPLAY "Test 29 " FELD4.

           MOVE 2 TO FELD4b
           SUBTRACT 1 FROM FELD4b
           IF FELD4b NOT = 1
              DISPLAY "Test 29b " FELD4b.

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

      *>   test with 18 digits (last implied zero by field)
      *>   -> maximum cob_u64_t for separate code branch
           MOVE 123456789.01234567 TO FELD5
           ADD 2 TO FELD5
           IF FELD5  NOT = 123456791.01234567
              DISPLAY "Test 41 ADD " FELD5.
           MOVE 123456789.01234567 TO FELD5
           SUBTRACT -2 FROM FELD5
           IF FELD5  NOT = 123456791.01234567
              DISPLAY "Test 41 SUBTRACT " FELD5.

      *>   now testing optimized functions (only used for non-scaled)
           MOVE 12345678901234567 TO FELD5b
           ADD 18518518351851850 TO FELD5b
           IF FELD5b  NOT = 30864197253086417
              DISPLAY "Test 41b ADD " FELD5b.
           MOVE 30864197253086417 TO FELD5b
           SUBTRACT 18518518351851850 FROM FELD5b
           IF FELD5b  NOT = 12345678901234567
              DISPLAY "Test 41b SUBTRACT " FELD5b.

      *>   tests with more than 19 digits for separate code branch
      *>   -> last 8 digits with implied zero by field
           MOVE 12345678.123456901234 TO FELD6
           ADD -2.1 TO FELD6
           IF FELD6  NOT = 12345676.023456901234
              DISPLAY "Test 42 ADD " FELD6.
           MOVE 12345678.123456901234 TO FELD6
           SUBTRACT 2.1 FROM FELD6
           IF FELD6  NOT = 12345676.023456901234
              DISPLAY "Test 42 SUBTRACT " FELD6.

      *>   -> first 8 digits with implied zero by field,
      *>      last 4 digits truncated
           MOVE .123456789012345678901234 TO FELD6
           ADD 1.8 TO FELD6
           IF FELD6  NOT = 1.9234567890123456789
              DISPLAY "Test 43 " FELD6.

      *>   now testing optimized functions (only used for non-scaled)
           MOVE 7123456789012345670 TO FELD6b
           ADD  1800000000000000000 TO FELD6b
           IF FELD6b  NOT = 8923456789012345670
              DISPLAY "Test 43b ADD " FELD6b.
           IF FELD6b  = -8923456789012345670
              DISPLAY "Test 43b2 ADD " FELD6b.
           MULTIPLY FELD6b BY -1 GIVING FELD6b
           IF FELD6b  NOT = -8923456789012345670
              DISPLAY "Test 43c NEGATIVE " FELD6b.
           IF FELD6b  = 8923456789012345670
              DISPLAY "Test 43c2 NEGATIVE " FELD6b.