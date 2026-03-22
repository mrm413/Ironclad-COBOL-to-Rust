IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "sub" OF "..".
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR.
           STOP RUN.