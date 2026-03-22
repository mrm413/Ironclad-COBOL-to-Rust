IDENTIFICATION   DIVISION.
       FUNCTION-ID.     func.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 PAR           PIC 9.
       PROCEDURE        DIVISION USING PAR RETURNING PAR.
           MOVE 4 TO PAR
           GOBACK.
       END FUNCTION     func.

       IDENTIFICATION   DIVISION.
       FUNCTION-ID.     func2.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 PAR-IN        PIC 9.
       01 PAR-OUT       REDEFINES PAR-IN PIC 9.
       PROCEDURE        DIVISION USING PAR-IN RETURNING PAR-OUT.
           MOVE 4 TO PAR-OUT
           GOBACK.
       END FUNCTION     func2.