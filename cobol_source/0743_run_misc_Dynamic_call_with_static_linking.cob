IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           CALL "callee"
           END-CALL.
           STOP RUN.