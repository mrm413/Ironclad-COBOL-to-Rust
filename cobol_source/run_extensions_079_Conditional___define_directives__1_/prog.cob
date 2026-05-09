IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
       >>IF ACTIVATE NOT DEFINED
           DISPLAY "OK" NO ADVANCING
           END-DISPLAY
       >>ELSE
           DISPLAY "NOTOK" NO ADVANCING
           END-DISPLAY
       >>END-IF
           STOP RUN.