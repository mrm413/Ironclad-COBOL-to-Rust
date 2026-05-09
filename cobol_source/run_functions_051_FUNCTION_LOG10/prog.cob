IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   S9V9(35).
       PROCEDURE        DIVISION.
           MOVE FUNCTION LOG10 ( 1.5 ) TO Y.
           IF Y NOT = 0.17609125905568124208128900853062228
              DISPLAY Y
              END-DISPLAY
           END-IF.
           STOP RUN.