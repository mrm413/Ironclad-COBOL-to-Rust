IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           CALL "mod1"
           END-CALL.
           IF RETURN-CODE NOT = 1
              DISPLAY RETURN-CODE NO ADVANCING
              END-DISPLAY
           END-IF.
           CALL "mod2"
           END-CALL.
           IF RETURN-CODE NOT = 0
              DISPLAY RETURN-CODE NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.