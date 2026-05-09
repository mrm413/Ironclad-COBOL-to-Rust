IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(6) VALUE "X".
       PROCEDURE        DIVISION.
           CALL "C$CALLEDBY" USING X
           END-CALL.
           IF RETURN-CODE = 0 AND
              X = SPACES
              DISPLAY "OK" NO ADVANCING
              END-DISPLAY
           END-IF.
           CALL "callee"
           END-CALL.
           STOP RUN.