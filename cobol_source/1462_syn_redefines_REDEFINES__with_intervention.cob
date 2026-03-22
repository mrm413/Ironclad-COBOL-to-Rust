IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
       01 Y             PIC X.
       01 A             REDEFINES X PIC X.
       01 G.
         02 G-X         PIC X.
         02 G-Y         PIC X.
         02 G-A         REDEFINES G-X PIC X.
       PROCEDURE        DIVISION.
           STOP RUN.