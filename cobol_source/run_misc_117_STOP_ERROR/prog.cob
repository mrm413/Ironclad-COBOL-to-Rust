IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           CALL "prog2".
           DISPLAY "Whatever".
           STOP RUN.
       END PROGRAM      prog.
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       PROCEDURE        DIVISION.
           STOP ERROR.