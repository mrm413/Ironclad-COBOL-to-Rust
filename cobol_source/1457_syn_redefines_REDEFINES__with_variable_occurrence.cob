IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X           PIC XX.
         02 Y           REDEFINES X PIC X OCCURS 1 TO 2 DEPENDING ON I.
       01 G2.
         02 X           PIC XX.
         02 Y           REDEFINES X.
           03 A         PIC X OCCURS 1 TO 2 DEPENDING ON I.
       01 G3.
         02 X.
           03 A         PIC X OCCURS 1 TO 2 DEPENDING ON I.
         02 Y           REDEFINES X PIC X.
       01 I             PIC 9.
       PROCEDURE        DIVISION.
           STOP RUN.