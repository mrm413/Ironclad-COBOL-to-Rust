IDENTIFICATION   DIVISION.
       PROGRAM-ID.      mod1.
       PROCEDURE        DIVISION.
           IF RETURN-CODE NOT = 0
              DISPLAY RETURN-CODE NO ADVANCING
              END-DISPLAY
           END-IF.
           MOVE 1 TO RETURN-CODE.
           IF RETURN-CODE NOT = 1
              DISPLAY RETURN-CODE NO ADVANCING
              END-DISPLAY
           END-IF.
           EXIT PROGRAM.