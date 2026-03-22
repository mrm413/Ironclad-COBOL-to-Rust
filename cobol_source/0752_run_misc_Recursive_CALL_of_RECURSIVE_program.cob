IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2 IS RECURSIVE.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  STOPPER      PIC S9 EXTERNAL.
       PROCEDURE        DIVISION.
           IF STOPPER NOT EQUAL -1
             CALL "callee"
           END-IF
           GOBACK.