IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       REPOSITORY.
           PROGRAM repo-prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78 DEFINED-CONST VALUE 'A'.
       77 MAIN-VAR      PIC X(3).
       PROCEDURE        DIVISION.
       MAIN.
           MOVE 'A' TO MAIN-VAR.
           MOVE 'B' TO MAIN.
           MOVE 'C' TO repo-prog.
           MOVE 'D' TO QUOTE.
           MOVE 'E' TO DEFINED-CONST.
           STOP RUN.