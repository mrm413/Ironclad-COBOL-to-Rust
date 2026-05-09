IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           CALL "m1"
           END-CALL.
           CALL "m2"
           END-CALL.
           CALL "m1"
           END-CALL.
           STOP RUN.