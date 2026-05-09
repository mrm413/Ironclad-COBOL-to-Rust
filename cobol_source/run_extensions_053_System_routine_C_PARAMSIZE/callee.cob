IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            USAGE BINARY-LONG.
       LINKAGE SECTION.
       01  Y            PIC   X ANY LENGTH.
       PROCEDURE        DIVISION USING Y.
           MOVE 1 TO X.
           CALL "C$PARAMSIZE" USING X
           END-CALL.
           IF RETURN-CODE NOT = 2
              DISPLAY "NOTOK "  RETURN-CODE
              END-DISPLAY
           END-IF.
           MOVE 0 TO RETURN-CODE.
           EXIT PROGRAM.