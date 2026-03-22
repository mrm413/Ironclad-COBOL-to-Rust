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

       REPORT SECTION.
       RD  rp.
       01  rp-head TYPE PH.
          02  LINE 1, COL 2 VALUE "Hello!".
          02  LINE PLUS 1.
              03 COLUMN 01      PIC X(09) VALUE 'CUST. NO.'.
              03 COLUMN PLUS 20 PIC X(09) VALUE 'ITEM'.


       PROCEDURE DIVISION.
           OPEN OUTPUT out-file.
           INITIATE rp.
           GENERATE rp-detail.
           TERMINATE rp.
           CLOSE out-file.
           STOP RUN.