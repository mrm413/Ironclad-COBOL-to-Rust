IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           CALL "callee1" ON EXCEPTION
              CALL "callee2" ON EXCEPTION
                  DISPLAY "neither calee1 nor callee2 found"
              END-CALL
           END-CALL
           GOBACK.