IDENTIFICATION   DIVISION.
       PROGRAM-ID.      "caller".
       PROCEDURE        DIVISION.
           CALL "callee"
           END-CALL.
           STOP RUN.
       PROGRAM-ID.      "callee".
       PROCEDURE        DIVISION.
           EXIT PROGRAM.
       END PROGRAM callee.
       END PROGRAM caller.