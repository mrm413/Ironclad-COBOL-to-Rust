IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"
            REPLACING TRAILING ==FIRST== BY ==VAR1==
                      TRAILING ==SECOND== BY ==VAR2==.
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR1 NO ADVANCING
           END-DISPLAY.
           DISPLAY TEST-VAR2 NO ADVANCING
           END-DISPLAY.
           STOP RUN.