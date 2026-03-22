IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   9V9(35).
       PROCEDURE        DIVISION.
           MOVE    FUNCTION E TO Y.
           IF Y NOT = 2.71828182845904523536028747135266249
              DISPLAY Y
              END-DISPLAY
           END-IF.
           STOP RUN.