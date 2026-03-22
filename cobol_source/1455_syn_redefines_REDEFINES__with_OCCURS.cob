IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 2.
         02 Y           REDEFINES X PIC XX.
       PROCEDURE        DIVISION.
           STOP RUN.