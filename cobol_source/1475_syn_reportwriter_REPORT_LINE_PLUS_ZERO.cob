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
          02  LINE 1  COL 5 PIC X(20) VALUE "Hello World!".
          02  LINE 2  COL 4 PIC X(20) VALUE "Hello Goodbye!".
          02  LINE PLUS 0.
              03 COLUMN  1      PIC X(09) VALUE 'CUST. No.'.
              03 COLUMN PLUS 0  PIC X(09) VALUE 'ITEM'.
          02  LINE PLUS ZERO.
              03 COLUMN 1       PIC X(09) VALUE 'Cust. No.'.
              03 COLUMN + 10    PIC X(09) VALUE 'Item'.

       01 rp-detail TYPE DETAIL.
          02 LINE PLUS 1.
             03 COLUMN 03   PIC X(06) VALUE 'SAMPLE'.

       PROCEDURE DIVISION.
           OPEN OUTPUT out-file.
           INITIATE rp.
           GENERATE rp-detail.
           TERMINATE rp.
           CLOSE out-file.
           STOP RUN.