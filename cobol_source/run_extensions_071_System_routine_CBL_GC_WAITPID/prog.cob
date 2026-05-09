IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 CHILD-PID   PIC S9(9) BINARY.
       01 WAIT-STS    PIC S9(9) BINARY VALUE -3.
       PROCEDURE DIVISION.

           CALL "CBL_GC_FORK" RETURNING CHILD-PID.
           EVALUATE CHILD-PID
              WHEN ZERO
                 PERFORM CHILD-CODE
              WHEN -1
                 STOP RUN RETURNING 77 *> skip test
              WHEN OTHER
                 PERFORM PARENT-CODE
           END-EVALUATE.

           STOP RUN.

       CHILD-CODE.
           CALL "C$SLEEP" USING 1.
           DISPLAY "Hello, I am the child".
           MOVE 2 TO RETURN-CODE.

       PARENT-CODE.
           DISPLAY "Hello, I am the parent".
           CALL "CBL_GC_WAITPID" USING CHILD-PID
              RETURNING WAIT-STS
           END-CALL
           MOVE 0 TO RETURN-CODE
           IF WAIT-STS = -1
              STOP RUN RETURNING 77 *> skip test
           END-IF
           DISPLAY "Child ended status " WAIT-STS
           END-DISPLAY.