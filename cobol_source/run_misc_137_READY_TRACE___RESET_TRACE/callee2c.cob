IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2c.
       PROCEDURE        DIVISION.
       SOME-SEC SECTION.
       SOME-PAR.
           PERFORM OTHER-SEC
           MOVE 0 TO RETURN-CODE.
       END-PAR.
           EXIT PROGRAM.
       OTHER-SEC SECTION.
           COMPUTE RETURN-CODE = 1 + 2.
       EX. EXIT.