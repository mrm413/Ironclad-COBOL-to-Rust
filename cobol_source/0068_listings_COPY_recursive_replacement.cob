IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy-1.inc"
           REPLACING ==TEST-VAR== BY ==COPY-VAR==.
       PROCEDURE        DIVISION.
           DISPLAY COPY-VAR NO ADVANCING
           END-DISPLAY.
           STOP RUN.