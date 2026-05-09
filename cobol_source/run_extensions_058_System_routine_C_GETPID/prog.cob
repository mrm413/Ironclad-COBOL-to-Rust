IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           CALL "C$GETPID"
           END-CALL.
           IF RETURN-CODE = 0
              DISPLAY "C$GETPID returned zero!"
              END-DISPLAY
           END-IF.
           MOVE 0 TO RETURN-CODE.
           STOP RUN.