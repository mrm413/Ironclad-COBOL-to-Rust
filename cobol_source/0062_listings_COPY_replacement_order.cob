IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"
          REPLACING ==TEST-VAR== BY ==FIRST-MATCH==
                    ==TEST-VAR== BY ==SECOND-MATCH==.
       PROCEDURE        DIVISION.
           DISPLAY FIRST-MATCH NO ADVANCING
           END-DISPLAY.
           STOP RUN.