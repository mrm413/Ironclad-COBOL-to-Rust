IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 10.
       01 I             PIC 9 VALUE 0.
       PROCEDURE        DIVISION.
           DISPLAY X(I)
           END-DISPLAY.
           STOP RUN.