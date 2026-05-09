IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee IS RECURSIVE.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  STOPPER      PIC S9 EXTERNAL.
       PROCEDURE        DIVISION.
           IF STOPPER = 9
              MOVE -1 TO STOPPER
           ELSE
              ADD   1 TO STOPPER
              CALL "callee2"
           END-IF
           GOBACK.