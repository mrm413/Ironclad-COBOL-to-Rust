IDENTIFICATION DIVISION.
       PROGRAM-ID. PGM1.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT FILE01 ASSIGN "file01.dat".
       DATA DIVISION.
       FILE SECTION.
       FD FILE01.
       01 RECORD-FILE01 PIC X(50).
       WORKING-STORAGE SECTION.
       01 W-DATA01.
      * 02 items may still lie in Area A for now:
       02 W-CH01       PIC X(10).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
       DISPLAY "Hello"
           STOP RUN
           .
       END PROGRAM PGM1.