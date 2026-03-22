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
       01   WS-INPUT-RECORD.
            05  WSI-A                           PIC X(1).
            05  WSI-B                           PIC X(1).
            05  WSI-C                           PIC X(1).
            05  WSI-V                           PIC 9.

       REPORT SECTION.
       RD  rp PAGE LIMIT 3.

       01  rp-detail TYPE DE.
         02  LINE PLUS 1.
            03  FILLER   SOURCE foo  PIC X(30).
            03  FILLER               PIC X(6) SOURCE "<--->".
            03  THING1               PIC 9(3) BINARY VALUE 12.
            03  THING2               COMP-2          VALUE 12.

       01 CF-A TYPE CONTROL FOOTING WSI-A.
           02 LINE PLUS 1.
              03 COLUMN 1 VALUE "**SUM:".
              03 COLUMN PLUS 2 SUM WSI-V.
              03 COLUMN PLUS 2 SUM WSI-V PIC XXX.

       PROCEDURE DIVISION.
           OPEN OUTPUT report-file.
           INITIATE rp.

           MOVE "hello" TO foo.
            GENERATE rp-detail.

           MOVE "goodbye" TO foo.
            GENERATE rp-detail.

           TERMINATE rp.
             CLOSE report-file.
           STOP RUN.
           END PROGRAM prog.