IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  str          PIC X(20).
       PROCEDURE        DIVISION.
      *>   Test normal inputs.
           MOVE FUNCTION FORMATTED-TIME ( "hhmmss", 45296 ) TO str
           IF str <> "123456"
               DISPLAY "Test 1 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hh:mm:ss", 45296 ) TO str
           IF str <> "12:34:56"
               DISPLAY "Test 2 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hhmmssZ", 86399, -1 ) TO str
           IF str <> "000059Z"
               DISPLAY "Test 3 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hh:mm:ssZ", 45296)
               TO str
           IF str <> "12:34:56Z"
               DISPLAY "Test 4 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hhmmss.ss", 45296.78 ) TO str
           IF str <> "123456.78"
               DISPLAY "Test 5 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hh:mm:ss.ssZ", 0, 120)
               TO str
           IF str <> "22:00:00.00Z"
               DISPLAY "Test 6 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hhmmss+hhmm", 45296)
               TO str
           IF str <> "123456+0000"
               DISPLAY "Test 7 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hh:mm:ss+hh:mm", 45296, 0 )
               TO str
           IF str <> "12:34:56+00:00"
               DISPLAY "Test 8 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hhmmss+hhmm", 45296, -754)
               TO str
           IF str <> "123456-1234"
               DISPLAY "Test 9 failed: " str END-DISPLAY
           END-IF

      *>   Test with invalid/missing offset times.
           MOVE FUNCTION FORMATTED-TIME ( "hhmmss+hhmm", 1, 3000 )
               TO str
           IF str <> SPACES
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 60"
               DISPLAY "Test 10 failed: " str END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME ( "hhmmss+hhmm", 1, -3000 )
               TO str
           IF str <> SPACES
                  OR FUNCTION EXCEPTION-STATUS <> "EC-ARGUMENT-FUNCTION"
                  OR FUNCTION EXCEPTION-LOCATION <> "prog; ; 68"
               DISPLAY "Test 11 failed: " str END-DISPLAY
           END-IF

           STOP RUN.