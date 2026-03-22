IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X           PIC X.
         02 A           REDEFINES X PIC 9.
         02 B           REDEFINES X PIC 9.
         02 C           REDEFINES B PIC 9.
       PROCEDURE        DIVISION.
           STOP RUN.