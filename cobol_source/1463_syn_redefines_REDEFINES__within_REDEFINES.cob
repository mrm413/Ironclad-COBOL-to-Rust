IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
       01 G             REDEFINES X.
         02 A           PIC X.
         02 B           REDEFINES A PIC 9.
       PROCEDURE        DIVISION.
           STOP RUN.