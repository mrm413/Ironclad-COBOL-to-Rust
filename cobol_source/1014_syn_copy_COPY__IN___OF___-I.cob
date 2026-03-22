IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc" IN sub2.
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR.
           STOP RUN.