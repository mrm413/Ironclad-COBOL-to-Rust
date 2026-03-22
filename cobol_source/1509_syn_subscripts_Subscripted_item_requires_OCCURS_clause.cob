IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X.
       PROCEDURE        DIVISION.
           DISPLAY G(1)
           END-DISPLAY.
           DISPLAY X(1)
           END-DISPLAY.
           STOP RUN.