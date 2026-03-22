IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       REPOSITORY.
           PROGRAM repo-prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 MAIN-VAR      PIC X(3).
       PROCEDURE        DIVISION.
       MAIN.
           MOVE MAIN TO MAIN-VAR.
           MOVE repo-prog TO MAIN.
           STOP RUN.