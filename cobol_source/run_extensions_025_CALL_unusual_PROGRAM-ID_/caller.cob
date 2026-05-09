IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           CALL "A@B"
           END-CALL.
           CALL "A@%:@B"
           END-CALL.
           CALL "A-B"
           END-CALL.
           CALL "A_B"
           END-CALL.
           STOP RUN.