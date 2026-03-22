IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X.
       01 Y             REDEFINES X PIC 9.
       PROCEDURE        DIVISION.
           STOP RUN.