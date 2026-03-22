IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           PERFORM 2 TIMES
             DISPLAY "OK" NO ADVANCING
             EXIT PERFORM CYCLE
             DISPLAY "NOT OK"
           END-PERFORM
           STOP RUN.