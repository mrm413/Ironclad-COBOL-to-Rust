IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller IS RECURSIVE.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  STOPPER      PIC S9 EXTERNAL.
       PROCEDURE        DIVISION.
           MOVE 0 TO STOPPER
           CALL "callee"
           DISPLAY 'OK' NO ADVANCING END-DISPLAY
      *> FIXME: CANCEL broken on special environments
      *>   CANCEL "callee" , "callee2"
           DISPLAY ' + FINE' NO ADVANCING END-DISPLAY
           STOP RUN.