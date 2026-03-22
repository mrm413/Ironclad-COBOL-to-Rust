IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc" OF SUB.
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR.
           STOP RUN.