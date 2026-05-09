IDENTIFICATION DIVISION.
       PROGRAM-ID. DemoExtProc IS RECURSIVE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  Ext-Proc-Address            USAGE PROCEDURE-POINTER.
       77  install-flag                USAGE BINARY-CHAR.
           88  install-default         VALUE 0.
           88  uninstall               VALUE 1.
           88  query-priority          VALUE 2.
           88  install-priority        VALUE 3.
       01  exit-params.
           02  proc-addrs              USAGE PROCEDURE-POINTER.
           02  ppriority               USAGE BINARY-CHAR.
       PROCEDURE DIVISION.
       S1.
           DISPLAY 'Program is starting'
      *>   Do this for the ACU test later
      *>   CALL 'CBL_EXIT_PROC' USING 0, "ExtProc-internal"
           SET Ext-Proc-Address TO ENTRY 'ExtProc'
      *>   GC "simple variant"
           CALL 'CBL_EXIT_PROC' USING 0, Ext-Proc-Address
      *>   Support for MF variant,
      *>   storing but otherwise ignoring the priority for now
           SET install-default  TO TRUE
           SET proc-addrs       TO ENTRY 'ExtProc-internal'
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
      *>   Ensure subsequent CALLs with the same one are seen as error (MF!)
           SET proc-addrs       TO ENTRY 'ExtProc'
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE = 0
              DISPLAY 'Unexpected RETURN-CODE with subsequent call '
                       RETURN-CODE.
           SET install-priority TO TRUE
           MOVE 127             TO ppriority
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE NOT = 0
              DISPLAY 'Unexpected RETURN-CODE with subsequent call, '
                      'different priority ' RETURN-CODE.
           SET proc-addrs       TO ENTRY 'ExtProc-internal2'
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE NOT = 0
              DISPLAY 'Unexpected RETURN-CODE with new call '
                       RETURN-CODE.
      *>
           DISPLAY 'Program is stopping'
           STOP RUN
           .
       ENTRY 'ExtProc-internal2'.
           DISPLAY 'Exit procedure from ' FUNCTION MODULE-ID ()
           SET Ext-Proc-Address TO ENTRY 'ExtProc'
           SET query-priority TO TRUE
           MOVE 0             TO ppriority
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE NOT = ZERO
              DISPLAY 'Unexpected RETURN-CODE for query '
                       RETURN-CODE
           ELSE IF ppriority NOT = 127
              DISPLAY 'Unexpected priority external ' ppriority.
           SET proc-addrs       TO ENTRY 'ExtProc-internal'
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE NOT = ZERO
              DISPLAY 'Unexpected RETURN-CODE for query '
                       RETURN-CODE
           ELSE IF ppriority NOT = 64
              DISPLAY 'Unexpected priority internal ' ppriority.
           SET uninstall      TO TRUE
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE NOT = 0
              DISPLAY 'Unexpected RETURN-CODE after uninstall '
                       RETURN-CODE.
           CALL 'CBL_EXIT_PROC' USING install-flag, exit-params
           IF RETURN-CODE = 0
              DISPLAY 'Unexpected RETURN-CODE after double uninstall '
                       RETURN-CODE.
           MOVE 0 TO RETURN-CODE
           GOBACK
           .
       ENTRY 'ExtProc-internal'.
           DISPLAY 'should have been removed'
           GOBACK
           .
       END PROGRAM DemoExtProc.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ExtProc.
       PROCEDURE DIVISION.
       000-Main.
           DISPLAY 'Exit procedure from ' FUNCTION MODULE-ID ()
           EXIT PROGRAM
           .
       END PROGRAM ExtProc.