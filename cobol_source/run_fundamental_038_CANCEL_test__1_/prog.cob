IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       PROCEDURE        DIVISION.
           CANCEL "notthere".
           CANCEL "prog".
           DISPLAY "NG" NO ADVANCING
           END-DISPLAY.
           STOP RUN.