IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee IS INITIAL.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  STOPPER      PIC 9 EXTERNAL.
       PROCEDURE        DIVISION.
           IF STOPPER = 8
              DISPLAY 'OK' NO ADVANCING END-DISPLAY.
           IF STOPPER NOT = 9
              ADD  1 TO STOPPER END-ADD
              CALL "callee2" END-CALL.
           GOBACK.