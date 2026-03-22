IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 G2          OCCURS 2.
           03 X         PIC X.
           03 Y         REDEFINES X(1) PIC X.
       PROCEDURE        DIVISION.
           STOP RUN.