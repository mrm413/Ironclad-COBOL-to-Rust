IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  STOPPER      PIC 9 EXTERNAL.
       PROCEDURE        DIVISION.
           MOVE 0 TO STOPPER
           CALL "callee" END-CALL.
           GOBACK.