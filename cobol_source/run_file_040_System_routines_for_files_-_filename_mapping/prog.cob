IDENTIFICATION DIVISION.
        PROGRAM-ID.     prog.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 FNAME        PIC X(256).
        01 RET          PIC -9.
        01 FHANDLE      PIC X(4)   USAGE COMP-X.

        01 OFFSET       PIC X(8)   USAGE COMP-X.
        01 NBYTES       PIC X(4)   USAGE COMP-X.
        01 READ-BUFFER  PIC X(10).

        PROCEDURE DIVISION CHAINING FNAME.
        DISPLAY 'RUN WITH ' FUNCTION TRIM (FNAME TRAILING).
        CALL 'CBL_OPEN_FILE' USING FNAME 1 0 0 FHANDLE.
        IF RETURN-CODE NOT = 0
           DISPLAY 'error opening file ...'
           MOVE 0 TO RETURN-CODE
           STOP RUN.

        CALL 'CBL_CLOSE_FILE' USING FHANDLE.
        IF RETURN-CODE NOT = 0
           DISPLAY 'error closing file ...'
                   return-code
           MOVE 0 TO RETURN-CODE.

        STOP RUN.