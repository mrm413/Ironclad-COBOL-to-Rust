IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2.
       PROCEDURE        DIVISION.
           COMPUTE RETURN-CODE
                 = 1 + 1
              ON SIZE ERROR
                 MOVE -1 TO RETURN-CODE
              NOT ON SIZE ERROR
                 COMPUTE RETURN-CODE
                       = 1 + 1
                 END-COMPUTE
           END-COMPUTE.
           CALL "callee2c" END-CALL
           CANCEL "callee2c"
           MOVE 0 TO RETURN-CODE.
           EXIT PROGRAM.