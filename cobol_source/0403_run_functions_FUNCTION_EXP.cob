IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   S99V9(34).
       PROCEDURE        DIVISION.
           MOVE FUNCTION EXP ( 3 ) TO Y.
           IF Y NOT = 20.0855369231876677409285296545817178
              DISPLAY Y
              END-DISPLAY
           END-IF.
           STOP RUN.