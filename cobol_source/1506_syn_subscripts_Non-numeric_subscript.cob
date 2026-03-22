IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X           PIC X OCCURS 10.
       01 I             PIC X.
       PROCEDURE        DIVISION.
           DISPLAY X(I)
           END-DISPLAY.
           DISPLAY X(I + 1)
           END-DISPLAY.
           STOP RUN.