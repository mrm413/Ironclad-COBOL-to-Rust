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

       REPORT SECTION.
       RD  rp PAGE LIMIT 3 LINES.

       01  rp-detail TYPE DE.
         02  LINE + 1.
         03            SOURCE foo, PIC X(30).
         03     COL + 2            PIC X(6) VALUE "<--->".

       PROCEDURE DIVISION.
           OPEN OUTPUT report-file.
           INITIATE rp.

           MOVE "hello" TO foo.
           GENERATE rp-detail.

           MOVE "world" TO foo.
           GENERATE rp-detail.

           MOVE "from" TO foo.
           GENERATE rp-detail.

           MOVE "REPORT WRITER" TO foo.
           GENERATE rp-detail.

           MOVE "goodbye" TO foo.
           GENERATE rp-detail.

           TERMINATE rp
           CLOSE report-file.

           STOP RUN.