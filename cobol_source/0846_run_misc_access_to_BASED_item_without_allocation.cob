IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) BASED.
       PROCEDURE        DIVISION.
           DISPLAY X NO ADVANCING
           STOP RUN.