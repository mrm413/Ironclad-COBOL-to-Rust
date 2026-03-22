IDENTIFICATION   DIVISION.
       FUNCTION-ID.     func.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 PAR-OUT       PIC 9.
       PROCEDURE        DIVISION RETURNING PAR-OUT.
           MOVE 4 TO PAR-OUT
           GOBACK.
       END FUNCTION     func.