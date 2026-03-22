IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       REPLACE   ==VAR-COLON== BY ==VAR-COMMA==.
       COPY "copy.inc"
          REPLACING ==:TEST:== BY ==COLON==.
       PROCEDURE        DIVISION.
           DISPLAY VAR-COLON NO ADVANCING
           END-DISPLAY.
           STOP RUN.
       REPLACE OFF.