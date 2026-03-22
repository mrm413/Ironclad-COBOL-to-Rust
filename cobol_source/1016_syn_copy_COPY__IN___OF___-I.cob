IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc" IN CBD.
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR.
           STOP RUN.