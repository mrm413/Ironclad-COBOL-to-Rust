IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"
          REPLACING ==:TEST:== BY ==COLON==
                    ==(TEST)== BY ==PAREN==.
       PROCEDURE        DIVISION.
           DISPLAY COLON-VAR NO ADVANCING
           END-DISPLAY.
           DISPLAY PAREN-VAR NO ADVANCING
           END-DISPLAY.
           STOP RUN.