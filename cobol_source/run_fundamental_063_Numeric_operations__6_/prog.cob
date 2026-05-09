IDENTIFICATION DIVISION.
        PROGRAM-ID. prog.

        DATA DIVISION.
        WORKING-STORAGE SECTION.

        01 P-FIELD1 PIC 99PPP.
        01 P-FIELD2 PIC PPP99.

        PROCEDURE DIVISION.

        MOVE 5000 TO P-FIELD1.
        ADD  5 TO P-FIELD1
        IF P-FIELD1 NOT = 5000
            DISPLAY "Error: Add 5 to PIC 99PPP.".
        CALL "dump" USING P-FIELD1.

        ADD  5000 TO P-FIELD1
        IF P-FIELD1 NOT = 10000
            DISPLAY "Error: Add 5000 to PIC 99PPP.".
        CALL "dump" USING P-FIELD1.

        MOVE 0.00055 TO P-FIELD2
        ADD  0.00033 TO P-FIELD2
        IF P-FIELD2 NOT = 0.00088
            DISPLAY "Error: Add 0.00033 to PIC PPP99.".
        CALL "dump" USING P-FIELD2.

        MOVE 0.00055 TO P-FIELD2
        ADD  0.00300 TO P-FIELD2
        IF P-FIELD2 NOT = 0.00055
            DISPLAY "Error: Add 0.00300 to PIC PPP99.".
        CALL "dump" USING P-FIELD2.

        STOP RUN.