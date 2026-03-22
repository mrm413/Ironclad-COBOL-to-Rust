IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 G2.
           03 X         PIC X.
         02 Y           REDEFINES X PIC 9.
       PROCEDURE        DIVISION.
           STOP RUN.