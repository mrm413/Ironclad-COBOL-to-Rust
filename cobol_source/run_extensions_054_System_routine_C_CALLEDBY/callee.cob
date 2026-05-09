IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(6) VALUE "X".
       PROCEDURE        DIVISION.
           CALL "C$CALLEDBY" USING X
           END-CALL.
           IF RETURN-CODE = 1 AND
              X = "caller"
              DISPLAY "OK" NO ADVANCING
              END-DISPLAY
           END-IF.
           EXIT PROGRAM.