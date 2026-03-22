IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 IMPHEAD.
          05 IMPPIC     VALUE " abc".
       PROCEDURE        DIVISION.
           DISPLAY IMPPIC END-DISPLAY
           STOP RUN.