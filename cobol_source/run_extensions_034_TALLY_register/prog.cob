IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       PROCEDURE        DIVISION.
           ADD  1 TO TALLY.
           CALL "nested".
           STOP RUN.

       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      nested.
       PROCEDURE        DIVISION.
           DISPLAY tally WITH NO ADVANCING.
           GOBACK.
       END PROGRAM      nested.