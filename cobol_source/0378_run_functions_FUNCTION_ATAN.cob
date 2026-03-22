IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   S9V9(35).
       PROCEDURE        DIVISION.
           MOVE FUNCTION ATAN ( 1 ) TO Y.
           IF Y NOT = 0.78539816339744830961566084581987572
              DISPLAY Y
              END-DISPLAY
           END-IF.
           STOP RUN.