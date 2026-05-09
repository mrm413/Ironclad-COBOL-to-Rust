IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            USAGE BINARY-LONG.
       LINKAGE SECTION.
       01  Y            PIC   X.
       PROCEDURE        DIVISION USING Y.
           CALL "C$NARG" USING X
           END-CALL
           IF X NOT = 1
              DISPLAY "NOTOK callee " X
              END-DISPLAY
           END-IF
           EXIT PROGRAM.