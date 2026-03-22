IDENTIFICATION DIVISION.
        PROGRAM-ID. prog.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 BLA PIC X(5) VALUE 'bluBb'.
        PROCEDURE DIVISION.
        MAIN-PROC SECTION.
        00.
        COPY PROC.
        END-PROC  SECTION.
        COPY PROCE in "sub".
        EX.
            STOP RUN.