IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT out-file ASSIGN "blah.txt"
           ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  out-file REPORT rp.

       WORKING-STORAGE SECTION.
       77  data-source pic x(20) value "data".

       REPORT SECTION.
       RD  rp.
       01  rp-head TYPE IS DETAIL.
          02  LINE 1, COL 2 VALUE "Hello!".
          02  LINE PLUS 1.
              03 COLUMN 01      PIC X(09) VALUE 'CUST. NO.'.
              03 ok  COLUMN PLUS 20 SOURCE IS data-source PIC X(10).
              03 bad COLUMN PLUS 20 SOURCE IS data-source.


       PROCEDURE DIVISION.
           STOP RUN.