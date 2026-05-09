IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 4 TO 6 DEPENDING ON N.
       01 N             PIC 9 VALUE 4.
       PROCEDURE        DIVISION.
           DISPLAY X(0)
           DISPLAY X(7)
           STOP RUN.