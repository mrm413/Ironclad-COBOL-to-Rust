IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G-1.
         02 X           PIC X OCCURS 1 TO 3 DEPENDING ON I.
         02 Y           PIC X.
       01 G-2.
         02 G-3         OCCURS 1 TO 3 DEPENDING ON I.
           03 X         PIC X.
         02 Y           PIC X.
       01 G-4.
         02 G-5.
           03 X         PIC X OCCURS 1 TO 3 DEPENDING ON I.
         02 Y           PIC X.
       01 I             PIC 9.