IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y            PIC   S9V9(35).
       PROCEDURE        DIVISION.
           MOVE FUNCTION COS ( -0.2345 ) TO Y.
           IF Y NOT = 0.97263064125625818471341696241456141
              DISPLAY Y
              END-DISPLAY
           END-IF.
           STOP RUN.