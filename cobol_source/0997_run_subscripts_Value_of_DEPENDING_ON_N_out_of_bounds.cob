IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 4 TO 6 DEPENDING ON N.
       01 N             PIC 9.
       PROCEDURE        DIVISION.
           MOVE 5 TO N.
           MOVE '12345' TO G
           DISPLAY X(3) WITH NO ADVANCING
           END-DISPLAY.
           MOVE 3 TO N.
           DISPLAY X(5)
           END-DISPLAY.
           STOP RUN.