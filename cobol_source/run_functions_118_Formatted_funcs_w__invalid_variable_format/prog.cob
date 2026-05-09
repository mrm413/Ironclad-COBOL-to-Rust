IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  invalid-date-format          PIC X(10) VALUE "yyyymmdd".
       01  invalid-datetime-format      PIC X(17)
                                        VALUE "yyyymmddtHHMMSS".
       01  invalid-time-format          PIC X(6) VALUE "HHMMSS".
       PROCEDURE        DIVISION.
           IF FUNCTION FORMATTED-CURRENT-DATE
                           (invalid-date-format) <> SPACES
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 11"
               DISPLAY "Test 1 failed" END-DISPLAY
           END-IF

           IF FUNCTION FORMATTED-DATE (invalid-date-format, 1) <> SPACES
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 18"
               DISPLAY "Test 2 failed" END-DISPLAY
           END-IF

           IF FUNCTION FORMATTED-DATETIME
                           (invalid-datetime-format, 1, 1) <> SPACES
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 24"
               DISPLAY "Test 3 failed" END-DISPLAY
           END-IF

           IF FUNCTION FORMATTED-TIME (invalid-time-format, 1) <> SPACES
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 31"
               DISPLAY "Test 4 failed" END-DISPLAY
           END-IF

           IF FUNCTION INTEGER-OF-FORMATTED-DATE
                           (invalid-date-format, 1) <> ZERO
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 37"
               DISPLAY "Test 5 failed" END-DISPLAY
           END-IF

           IF FUNCTION SECONDS-FROM-FORMATTED-TIME
                           (invalid-time-format, 1) <> ZERO
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 44"
               DISPLAY "Test 6 failed" END-DISPLAY
           END-IF

           IF FUNCTION TEST-FORMATTED-DATETIME
                           (invalid-datetime-format, 1) <> ZERO
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 51"
               DISPLAY "Test 7 failed" END-DISPLAY
           END-IF

           STOP RUN.