IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      *>****************************************************************
      *> 11NOV2013 BUG 003 - RWCS causes "Abort trap 6" if an attempt **
      *>                     is made to overwrite previous field on   **
      *>                     a line                                   **
      *>****************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REPORT-FILE          ASSIGN TO EXTERNAL PRINTOUT
                                       LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  REPORT-FILE
           REPORT IS RWCS-Report.
       WORKING-STORAGE SECTION.
       REPORT SECTION.
       RD  RWCS-Report
           PAGE LIMIT 12
               HEADING 1
               FIRST DETAIL 4
               LAST DETAIL 7.

       01  Detail-Line TYPE DETAIL.
           05 LINE NUMBER PLUS 1.
              10 COL 1      PIC X(20)  VALUE '12345678901234567890'.
              10 COL 10     PIC X(4)   VALUE 'ABCD'.

       PROCEDURE DIVISION.
       010-Main SECTION.
       1.  OPEN OUTPUT REPORT-FILE
           INITIATE RWCS-Report
           GENERATE Detail-Line
           TERMINATE RWCS-Report
           CLOSE REPORT-FILE
           .