IDENTIFICATION DIVISION.
        PROGRAM-ID. prog.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 DIR PIC X(4) VALUE 'ABCD'.

        PROCEDURE DIVISION.
        CALL 'CBL_CREATE_DIR' USING DIR END-CALL
        IF RETURN-CODE NOT = 0
            DISPLAY 'error creating dir ...' END-DISPLAY
        END-IF

        CALL 'CBL_CHANGE_DIR' USING DIR END-CALL
        IF RETURN-CODE NOT = 0
            DISPLAY 'error changing dir ...' END-DISPLAY
        END-IF

        CALL 'CBL_CHANGE_DIR' USING '..' END-CALL
        IF RETURN-CODE NOT = 0
            DISPLAY 'error changing dir up ...' END-DISPLAY
        END-IF

        CALL 'CBL_DELETE_DIR' USING DIR END-CALL
        IF RETURN-CODE NOT = 0
            DISPLAY 'error deleting dir' END-DISPLAY
        END-IF

        STOP RUN.