$SET ODOSLIDE
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G-1.
         02 G-2         OCCURS 10.
           03 X         PIC X(10) OCCURS 1 TO 4 DEPENDING ON I.
       77 I             PIC 9.