IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT report-file ASSIGN EXTERNAL PRINTOUT
            ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  report-file REPORT rp.

       WORKING-STORAGE SECTION.
       01  foo  PIC X(20).
       01  hedpos PIC 99 VALUE 10.

       REPORT SECTION.
       RD  rp PAGE LIMIT 3.

       01  rp-detail TYPE DE.
         02  LINE + 1.
         03     COL 1; SOURCE foo, PIC X(30).
         03     COL + 2            PIC X(6) VALUE "<--->".

       PROCEDURE DIVISION.
           OPEN OUTPUT report-file.

           TERMINATE rp.
           CLOSE report-file.
           STOP RUN.