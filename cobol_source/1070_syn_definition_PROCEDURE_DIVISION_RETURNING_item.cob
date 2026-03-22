IDENTIFICATION   DIVISION.
       FUNCTION-ID.     func.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 PAR-OUT       PIC 9 OCCURS 10.
       PROCEDURE        DIVISION RETURNING PAR-OUT.
           MOVE 4 TO PAR-OUT (1)
           GOBACK.
       END FUNCTION     func.