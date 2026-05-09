IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           CALL STATIC "callee"
           END-CALL.
           STOP RUN.