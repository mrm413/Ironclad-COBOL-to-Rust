IDENTIFICATION DIVISION.
        PROGRAM-ID.     prog2.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 FNAME        PIC X(256) VALUE 'testtext.txt'.
        01 RET          PIC -9.
        01 FHANDLE      PIC X(4)   USAGE COMP-X.

        01 OFFSET       PIC X(8)   USAGE COMP-X.
        01 NBYTES       PIC X(4)   USAGE COMP-X.
        01 READ-BUFFER  PIC X(10).

        PROCEDURE DIVISION.
        CALL 'CBL_OPEN_FILE' USING FNAME 1 0 0 FHANDLE
        END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error opening file ...' END-DISPLAY
           GOBACK
        END-IF

        CALL 'CBL_READ_FILE' USING
        FHANDLE OFFSET NBYTES 128 READ-BUFFER
        END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error getting file size...'
                   return-code
           END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF
        IF OFFSET NOT = 9 *> size written in the first test
           DISPLAY 'Wrong size: ' offset END-DISPLAY
           *> still go on with the explicit size
        ELSE
           *> recheck with unexpected parms:
           MOVE 'baddy' to offset(1:)
           CALL 'CBL_READ_FILE' USING
           FHANDLE OFFSET 0 128 NULL
           END-CALL
           IF RETURN-CODE NOT = 0 or OFFSET NOT = 9
              DISPLAY 'bad handling bad parms '
                      'size: ' offset  ' return: ' return-code
              END-DISPLAY
              MOVE 0 TO RETURN-CODE
           END-IF
        END-IF

        MOVE SPACES TO READ-BUFFER.
        MOVE 2 TO OFFSET.
        MOVE 9 TO NBYTES.

        CALL 'CBL_READ_FILE' USING
        FHANDLE OFFSET NBYTES 0 READ-BUFFER
        END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error reading file ...'
                   return-code
           END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF
        IF READ-BUFFER NOT = 'stText.' *> text from first test
           DISPLAY 'Wrong readbuffer ...' END-DISPLAY
        END-IF

        CALL 'CBL_CLOSE_FILE' USING FHANDLE END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error closing file ...'
                   return-code
           END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF

        CALL 'CBL_RENAME_FILE' USING FNAME 'foo.txt' END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error renaming file ...'
                   return-code
           END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF

        CALL 'CBL_DELETE_FILE' USING 'file1' END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error deleting file1 ...'
                   return-code
           END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF
        CALL 'CBL_DELETE_FILE' USING 'file1' END-CALL
        IF RETURN-CODE = 0
           DISPLAY 'no error on deleting file1 for the second time...'
                   return-code
           END-DISPLAY
        END-IF
        MOVE 0 TO RETURN-CODE

        CALL 'C$DELETE' USING 'file2' 'S' END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error deleting file2 ...'
                   return-code
           END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF
        CALL 'CBL_DELETE_FILE' USING 'file2' END-CALL
        IF RETURN-CODE = 0   *> note: should only return 0 or 1 when in ACUCOBOL mode
           DISPLAY 'no error on deleting file2 for the second time...'
                   return-code
           END-DISPLAY
        END-IF
        MOVE 0 TO RETURN-CODE

        STOP RUN.