IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 10.
       01 I             PIC 99 VALUE 11.
       PROCEDURE        DIVISION.
           DISPLAY X(I)
           END-DISPLAY.
           STOP RUN.