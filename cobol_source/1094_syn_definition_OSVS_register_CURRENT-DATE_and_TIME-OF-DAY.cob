IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 current-date  pic x(08).
       PROCEDURE        DIVISION.
           MOVE 'unknown' TO CURRENT-DATE
           STOP RUN.