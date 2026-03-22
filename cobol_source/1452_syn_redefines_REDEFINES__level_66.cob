IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X.
         66 A           RENAMES X.
         66 B           REDEFINES A PIC 9.
       PROCEDURE        DIVISION.
           STOP RUN.