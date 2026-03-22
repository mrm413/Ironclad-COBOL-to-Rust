IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee1.
       PROCEDURE        DIVISION.
           ADD 1 TO RETURN-CODE
             NOT ON SIZE ERROR
               IF RETURN-CODE = 1
                 CONTINUE
               ELSE IF RETURN-CODE = 2
                 CONTINUE
               ELSE
                 CONTINUE
           .
           EVALUATE RETURN-CODE
           WHEN 1
             CONTINUE
           WHEN 2
           WHEN 3
             CONTINUE
           WHEN OTHER
             CONTINUE
           END-EVALUATE
           EVALUATE TRUE
           WHEN RETURN-CODE = 1
             CONTINUE
           WHEN RETURN-CODE = 2
           WHEN RETURN-CODE = 3
             CONTINUE
           WHEN OTHER
             CONTINUE
           END-EVALUATE
           CALL "callee2"  END-CALL
           CANCEL "callee2"  CALL "callee2b" END-CALL  CANCEL "callee2b"
           SUBTRACT 1 FROM RETURN-CODE
           EXIT PROGRAM.