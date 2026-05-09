IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 CHILD-PID   USAGE BINARY-LONG.
       77 PARENT-PID  USAGE BINARY-LONG.
       PROCEDURE DIVISION.

           CALL "C$GETPID" RETURNING PARENT-PID
           CALL "CBL_GC_FORK" END-CALL
           EVALUATE RETURN-CODE
              WHEN ZERO
                 PERFORM CHILD-CODE
              WHEN -1
                 STOP RUN RETURNING 77 *> skip test
              WHEN OTHER
                 PERFORM PARENT-CODE
           END-EVALUATE

           STOP RUN.

       CHILD-CODE.
           CALL "C$SLEEP"  USING 1.
           DISPLAY "Hello, I am the child".
           CALL "C$GETPID" RETURNING CHILD-PID.
           IF CHILD-PID = PARENT-PID
              DISPLAY "CHILD: parent and child have same PID: "
                      "'" CHILD-PID "'" UPON SYSERR
              END-DISPLAY
           END-IF.
           MOVE 0 TO RETURN-CODE.

       PARENT-CODE.
           DISPLAY "Hello, I am the parent".
           CALL "C$SLEEP"  USING 4.
           DISPLAY "Parent again".
           IF RETURN-CODE = PARENT-PID
              DISPLAY "PARENT: parent and child have same PID: "
                      "'" PARENT-PID "'" UPON SYSERR
              END-DISPLAY
           END-IF.
           CALL "C$GETPID".
           IF RETURN-CODE NOT = PARENT-PID
              DISPLAY "PARENT: parent PID has changed: "
                      "'" PARENT-PID "' -> '" RETURN-CODE "'"
                      UPON SYSERR
              END-DISPLAY
           END-IF.
           MOVE 0 TO RETURN-CODE.