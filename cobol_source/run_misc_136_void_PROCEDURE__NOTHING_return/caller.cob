IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           MOVE 42 TO RETURN-CODE
           CALL "callee" RETURNING NOTHING
           END-CALL.
           IF RETURN-CODE NOT = 42
              DISPLAY 'unexpected RETURN-CODE: ' RETURN-CODE.
           STOP RUN.