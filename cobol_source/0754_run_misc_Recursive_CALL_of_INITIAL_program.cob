IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee IS INITIAL.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  STOPPER      PIC 9 EXTERNAL.
       PROCEDURE        DIVISION.
           IF STOPPER = 1
              DISPLAY 'INITIAL prog was called RECURSIVE'
              END-DISPLAY
              STOP RUN RETURNING 1
           ELSE
              MOVE 1 TO STOPPER
              CALL "callee2" END-CALL
           END-IF.
           GOBACK.