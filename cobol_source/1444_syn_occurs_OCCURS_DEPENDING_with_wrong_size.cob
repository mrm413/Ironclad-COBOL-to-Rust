IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 FILLER.
         02 G-1         PIC X OCCURS  1 TO 1 DEPENDING ON I.
       01 FILLER.
         02 G-2         PIC X OCCURS -1 TO 1 DEPENDING ON I.
       01 FILLER.
         02 G-3         PIC X OCCURS +1 TO 1 DEPENDING ON I.
       01 FILLER.
         02 G-4         PIC X OCCURS  0 TO 1 DEPENDING ON I.
       01 I             PIC 9.