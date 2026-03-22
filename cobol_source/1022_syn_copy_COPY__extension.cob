IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "sub".
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR.
           STOP RUN.