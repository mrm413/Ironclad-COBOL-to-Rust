IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           IF 1 = (1 OR 2)
             DISPLAY "OK" NO ADVANCING
             END-DISPLAY
           END-IF.
           STOP RUN.