IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 I PIC 9.
       01 G-1 VALUE "123456789".
         02 G-2.
           03 X   PIC X OCCURS 1 TO 3 DEPENDING ON I.
         02 G-3.
           03 G-4.
             04 X PIC X OCCURS 1 TO 3 DEPENDING ON I.
           03 G-5.
             04 X PIC X OCCURS 1 TO 3 DEPENDING ON I.
       PROCEDURE        DIVISION.
           MOVE 2 TO I.
           DISPLAY G-1 ":" G-4 ":" G-5 NO ADVANCING
           .