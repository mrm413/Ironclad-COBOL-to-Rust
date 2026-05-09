IDENTIFICATION DIVISION.
       PROGRAM-ID. DemoErrProc.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  Err-Proc-Address            USAGE PROGRAM-POINTER.
       77  Err-Message-Len             PIC 9(04) USAGE COMP-5.
       LOCAL-STORAGE SECTION.  *> can even be empty...
       LINKAGE SECTION.
       77  Err-Message-From-Runtime    PIC X(1023).
       PROCEDURE DIVISION.
       S1.
           DISPLAY 'Program is starting'
           SET Err-Proc-Address TO ENTRY 'ErrProc'
           CALL 'CBL_ERROR_PROC' USING 0, Err-Proc-Address
           SET Err-Proc-Address TO ENTRY 'ErrProc-internal'
           CALL 'CBL_ERROR_PROC' USING 0, Err-Proc-Address
           SET Err-Proc-Address TO NULL
           CALL 'Tilt' *> THIS DOESN'T EXIST!!!!
           DISPLAY 'Program is stopping'
           STOP RUN
           .
       ENTRY 'ErrProc-internal' USING Err-Message-From-Runtime.
           DISPLAY 'Error (interal): ' FUNCTION EXCEPTION-LOCATION  '-'
           DISPLAY '                 ' FUNCTION EXCEPTION-STATEMENT '-'
           DISPLAY '                 ' FUNCTION EXCEPTION-STATUS    '-'
           *> NOTE: the error message is *EXPLICIT* specified to end with x'00'
           MOVE 0 TO Err-Message-Len
           INSPECT Err-Message-From-Runtime
              TALLYING Err-Message-Len FOR CHARACTERS BEFORE x'00'
           DISPLAY 'Error-Message:   ' Err-Message-From-Runtime
                                       (1:Err-Message-Len)
           DISPLAY '-*- Stop error routines here -*-'
           MOVE    0         TO RETURN-CODE
           EXIT PROGRAM
           .
       END PROGRAM DemoErrProc.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ErrProc.
       PROCEDURE DIVISION.
       000-Main.
           DISPLAY 'Error: ' FUNCTION EXCEPTION-LOCATION  '-'
           DISPLAY '       ' FUNCTION EXCEPTION-STATEMENT '-'
           DISPLAY '       ' FUNCTION EXCEPTION-STATUS    '-'
           DISPLAY '-*- Returning to Standard Error Routine -*-'
           MOVE    1         TO RETURN-CODE
           EXIT PROGRAM
           .
       END PROGRAM ErrProc.