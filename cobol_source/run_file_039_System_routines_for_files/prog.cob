IDENTIFICATION DIVISION.
        PROGRAM-ID.     prog.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 FNAME        PIC X(256) VALUE 'testtext.txt'.
        01 ACCESS-MODE  PIC X      USAGE COMP-X VALUE 2.
        01 FHANDLE      PIC X(4)   USAGE COMP-X.

        01 OFFSET       PIC X(8)   USAGE COMP-X.
        01 NBYTES       PIC X(4)   USAGE COMP-X.
        01 WRITE-BUFFER PIC X(20).

        PROCEDURE DIVISION.
        CALL 'CBL_CREATE_FILE' USING FNAME 55 11 22 FHANDLE
        END-CALL
        IF RETURN-CODE NOT = -1
           DISPLAY 'Wrong return codes ...' END-DISPLAY
        END-IF
        MOVE 0 TO RETURN-CODE

        CALL 'CBL_CREATE_FILE' USING
        FNAME ACCESS-MODE 0 0 FHANDLE
        END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error creating file ...' END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF

        MOVE 'TestText.ABCD' TO WRITE-BUFFER.
        MOVE 0 TO OFFSET.
        MOVE 9 TO NBYTES.

        CALL 'CBL_WRITE_FILE' USING
        FHANDLE OFFSET NBYTES '0' WRITE-BUFFER
        END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error writing file ...' END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF

        CALL 'CBL_FLUSH_FILE' USING FHANDLE END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error flushing file ...' END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF

        CALL 'CBL_CLOSE_FILE' USING FHANDLE END-CALL
        IF RETURN-CODE NOT = 0
           DISPLAY 'error closing file ...' END-DISPLAY
           MOVE 0 TO RETURN-CODE
        END-IF

        STOP RUN.