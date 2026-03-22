IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   X(24).
       01  Z   USAGE BINARY-LONG.
       PROCEDURE        DIVISION.
           MOVE "123456789012" TO Y.
           MOVE FUNCTION STORED-CHAR-LENGTH ( Y ) TO Z.
           IF Z NOT = 12
              DISPLAY Z.
           STOP RUN.