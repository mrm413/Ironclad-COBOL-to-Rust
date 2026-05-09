IDENTIFICATION DIVISION.
        PROGRAM-ID. subprog.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        LINKAGE SECTION.
        01 F1 PIC X(10).
        01 F2 PIC X(15).

        PROCEDURE DIVISION USING F1 F2.
        MOVE F1(1:8) TO F2 (7:8).
        IF F2 NOT = "Hallo1111111110"
           DISPLAY "error:3: " F2.

        GOBACK.