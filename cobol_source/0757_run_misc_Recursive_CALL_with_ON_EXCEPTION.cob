IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2.
       PROCEDURE        DIVISION.
           CALL "callee"
           ON EXCEPTION
              DISPLAY "Exception " FUNCTION EXCEPTION-STATUS ";"
                 UPON SYSERR
              STOP RUN RETURNING 1
           END-CALL.
           GOBACK.