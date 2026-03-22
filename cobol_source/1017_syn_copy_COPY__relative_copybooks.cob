IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc" IN SUB2.
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR TEST-VAR2.
           STOP RUN.