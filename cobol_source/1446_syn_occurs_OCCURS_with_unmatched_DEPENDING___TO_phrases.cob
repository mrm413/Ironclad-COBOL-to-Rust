IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 Y             PIC 9.
       01 XTAB.
          03 X  PIC X OCCURS 10 DEPENDING ON Y.
       01 XTAB2.
          03 X2 PIC X OCCURS 1 TO 10.
       01 XTAB3.
          03 X3 PIC X OCCURS 1 TO 10 DEPENDING ON MISSING.
       PROCEDURE DIVISION.
           MOVE 'A' TO X(1), X2(2), X3(3)
           GOBACK.