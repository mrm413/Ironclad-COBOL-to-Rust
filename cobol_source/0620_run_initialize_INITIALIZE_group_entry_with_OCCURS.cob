IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 G2          OCCURS 2.
           03 X1        PIC X.
           03 X2        PIC 9.
       PROCEDURE        DIVISION.
           MOVE SPACE TO G1.
           INITIALIZE G2 (2).
           IF G1 NOT = "   0"
              DISPLAY G1 NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.