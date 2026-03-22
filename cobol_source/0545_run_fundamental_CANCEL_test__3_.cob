IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       PROCEDURE        DIVISION.
           CALL "prog2".
           CALL "prog2".
           CANCEL "prog2".
           CALL "prog2".
           CANCEL "prog2".
           DISPLAY "NG" NO ADVANCING.
           STOP RUN.