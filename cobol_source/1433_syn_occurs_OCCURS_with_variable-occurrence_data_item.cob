IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G-1.
         02 G-2         OCCURS 1 TO 10 DEPENDING ON I.
           03 X         PIC X(10) OCCURS 1 TO 4 DEPENDING ON I.
       77 I             PIC 9.
       PROCEDURE        DIVISION.
           DISPLAY  X(I, I) END-DISPLAY
           DISPLAY  G-2 (I) END-DISPLAY
           DISPLAY  G-1     END-DISPLAY
           .