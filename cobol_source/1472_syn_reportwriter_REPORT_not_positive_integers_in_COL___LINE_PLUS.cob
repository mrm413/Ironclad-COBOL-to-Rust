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
          02  LINE NUMBER IS 1, COLUMNS 0 VALUE "Hello!".
          02  LINE IS 2,        COLS    2 VALUE "Hello!".
          02  LINE NUMBERS ARE PLUS 1.
              03 COLUMN NUMBER 01  PIC X(09) VALUE 'CUST. NO.'.
              03 COLUMN PLUS 0     PIC X(09) VALUE 'ITEM'.
          02  LINES ARE PLUS 2 COL NUMBERS PLUS 0.
              03 COLUMN 1.5        PIC X(09) VALUE 'CUST. NO.'.
              03 COLUMN + -10      PIC X(09) VALUE 'ITEM'.

       01 rp-detail TYPE DETAIL.
          02 LINE PLUS 1.
             03 COLUMN 03   PIC X(06) VALUE 'SAMPLE'.
             03 COLUMN +9   PIC X(06) VALUE 'REPORT'.

       PROCEDURE DIVISION.
           OPEN OUTPUT out-file.
           INITIATE rp.
           GENERATE rp-detail.
           TERMINATE rp.
           CLOSE out-file.
           STOP RUN.