IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   S9V9(35).
       PROCEDURE        DIVISION.
           MOVE FUNCTION LOG ( 1.5 ) TO Y.
           IF Y NOT = 0.40546510810816438197801311546434913
              DISPLAY Y
              END-DISPLAY
           END-IF.
           STOP RUN.