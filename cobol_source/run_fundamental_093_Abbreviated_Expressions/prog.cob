IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           SWITCH-1
           IS WRK-SWITCH-1
           ON STATUS IS ON-WRK-SWITCH-1
           OFF STATUS IS OFF-WRK-SWITCH-1
           SWITCH-2
           IS WRK-SWITCH-2
           OFF STATUS IS OFF-WRK-SWITCH-2.
       DATA DIVISION.
      ******************************************************************
       WORKING-STORAGE SECTION.
      *
       01 FLD9-0   PIC 9 VALUE 0.
       01 FLD9-1   PIC 9 VALUE 1.
       01 FLD9-2   PIC 9 VALUE 2.
       01 FLD9-5   PIC 9 VALUE 5.
       01 FLD9-7   PIC 9 VALUE 7.
       01 FLD9-9   PIC 9 VALUE 9.
       01 FLDX     PIC X VALUE 'X'.
       01 FLDY     PIC X VALUE 'Y'.
       01 FLDYY    PIC X VALUE 'Y'.
       01 FLDZ     PIC X VALUE 'Z'.
       01 TESTNUM  PIC 99 VALUE 1.

       PROCEDURE DIVISION.
       MAIN-LINE.

           IF FLD9-7 > FLD9-5 AND NOT < FLD9-0 OR FLD9-1
                PERFORM PASS ELSE PERFORM FAIL.
           IF FLD9-7 NOT = FLD9-5 OR FLD9-1
                PERFORM PASS ELSE PERFORM FAIL.
           IF FLD9-7 NOT = FLD9-5 AND FLD9-1
                PERFORM PASS ELSE PERFORM FAIL.
           IF NOT FLD9-7 = FLD9-5 OR FLD9-1
                PERFORM PASS ELSE PERFORM FAIL.
           IF NOT (FLD9-5 > FLD9-7 OR < FLD9-1)
                PERFORM PASS ELSE PERFORM FAIL.
           IF NOT (FLD9-7 NOT > FLD9-5 AND FLD9-2 AND NOT FLD9-1)
                PERFORM PASS ELSE PERFORM FAIL.
           IF FLD9-9 > FLD9-2 AND FLD9-7 AND FLD9-5
                PERFORM PASS ELSE PERFORM FAIL.
           IF FLD9-9 > FLD9-2 AND FLD9-7 OR FLD9-5
                PERFORM PASS ELSE PERFORM FAIL.
           IF FLD9-1 < FLD9-2 AND FLD9-5 AND FLD9-7
                PERFORM PASS ELSE PERFORM FAIL.

      * // DISPLAY "***Constant expressions***".
           IF 9 > 2 AND 7 AND 5 AND 1
                PERFORM PASS ELSE PERFORM FAIL.
           IF 1 < 2 AND 5 AND 7 AND 9
                PERFORM PASS ELSE PERFORM FAIL.
           IF 5 < 2 OR 1 OR 9 OR 7
                PERFORM PASS ELSE PERFORM FAIL.
           IF 5 > 1 AND < 3 OR 6
                PERFORM PASS ELSE PERFORM FAIL.

      * // DISPLAY "***Switch expressions***".
           IF           ON-WRK-SWITCH-1
                 OR NOT OFF-WRK-SWITCH-2
                AND     OFF-WRK-SWITCH-1
                PERFORM FAIL ELSE PERFORM PASS.
           DISPLAY "***FINE***" WITH NO ADVANCING.
           STOP RUN.

       PASS.
      * // DISPLAY 'Test ' TESTNUM ' passed'
           ADD 1 TO TESTNUM.

       FAIL.
           DISPLAY 'Test ' TESTNUM ' failed!'
           ADD 1 TO TESTNUM.