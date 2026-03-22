IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       COPY "copy.inc".
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           DISPLAY FIRST-MATCH NO ADVANCING
           END-DISPLAY.
           STOP RUN.