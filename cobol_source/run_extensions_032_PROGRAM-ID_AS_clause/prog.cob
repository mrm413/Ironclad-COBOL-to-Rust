IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller AS "PROG".
       PROCEDURE        DIVISION.
           CALL "prog"
           END-CALL.
           STOP RUN.
       PROGRAM-ID.      callee AS "prog".
       PROCEDURE        DIVISION.
           EXIT PROGRAM.
       END PROGRAM callee.
       END PROGRAM caller.