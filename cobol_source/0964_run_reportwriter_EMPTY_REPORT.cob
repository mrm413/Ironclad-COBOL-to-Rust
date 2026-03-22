IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      *>****************************************************************
      *> 11NOV2013 BUG 004 - RWCS INITIATE TERMINATE W/O GENERATE     **
      *>                     IS NOT SUPPOSED TO PRODUCE ANY OUTPUT    **
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
               LAST DETAIL 7
           CONTROL IS FINAL.

       01  TYPE REPORT HEADING LINE 1.
           05 COL 1 VALUE 'RH'.

       01  TYPE PAGE HEADING LINE PLUS 1.
           05 COL 1 VALUE 'PH'.

       01  Detail-Line TYPE DETAIL LINE PLUS 1.
           05 COL 1 VALUE 'DE'.

       01  TYPE CONTROL FOOTING FINAL.
           05 COL 1 VALUE 'CFF'.

       01  TYPE PAGE FOOTING LINE NUMBER 10.
           05 COL 1 VALUE 'PF'.

       01  TYPE REPORT FOOTING LINE NUMBER 1.
           05 COL 1 VALUE 'RF'.

       PROCEDURE DIVISION.
       010-Main SECTION.
       1.  OPEN OUTPUT REPORT-FILE
           INITIATE RWCS-Report
           TERMINATE RWCS-Report
           CLOSE REPORT-FILE
           .