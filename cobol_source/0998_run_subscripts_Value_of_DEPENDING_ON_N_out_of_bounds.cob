IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 4 TO 6 DEPENDING ON N.
       01 N             PIC 9 VALUE 7.
       PROCEDURE        DIVISION.
           DISPLAY X(5)
           END-DISPLAY.
           STOP RUN.