IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      *AUTHOR.          Gerard Robinson.
      *DATE-WRITTEN.    February 25, 2015.
       
       ENVIRONMENT DIVISION.
       
       INPUT-OUTPUT SECTION.
       
       FILE-CONTROL.
       
       SELECT REPORT-FILE
              ASSIGN TO EXTERNAL REPORTFILE
              ORGANIZATION IS LINE SEQUENTIAL.
       
       SELECT TEMP-FILE
              ASSIGN TO EXTERNAL TEMPFILE
              ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       
       FILE SECTION.
       
       FD  REPORT-FILE
           REPORT IS RPTA.
       
       FD  TEMP-FILE.
       
       01  TEMP-REC.
         03  TEMP-REGION        PIC X(2).
         03  TEMP-BRANCH        PIC X(7).
         03  TEMP-INVOICE       PIC X(8).
         03  TEMP-DATE          PIC X(8).
         03  TEMP-ORDER         PIC X(8).
         03  TEMP-LINE-NO       PIC X(3).
         03  TEMP-ITEM          PIC X(20).
         03  TEMP-TX-QTY        PIC S9(8).
         03  TEMP-COST          PIC 999999V99.
       
       WORKING-STORAGE SECTION.
       
       01 WS-CURRENT-DATE PIC X(23).
       
       01 WS-SYSTEM-DATE-R REDEFINES WS-CURRENT-DATE.
          05 WS-DATE-YYYY          PIC X(4).
          05 WS-DATE-MM            PIC X(2).
          05 WS-DATE-DD            PIC X(2).
          05 WS-TIME               PIC X(6).
          05 WS-REST               PIC X(9).
       
       01 TEMP-FILE-EOF        PIC 9 VALUE 0.
       
       REPORT SECTION.
       
       RD  RPTA
           CONTROLS ARE
             FINAL,
             TEMP-REGION,
             TEMP-BRANCH,
             TEMP-INVOICE
       
           PAGE LIMIT IS 60 LINES
           HEADING 1
           FIRST DETAIL 8
           LAST DETAIL  48.
       
       01 RPTA-PAGE-HEADING TYPE PAGE HEADING.
          03 LINE NUMBER IS 1.
             05 COLUMN 1    PIC X(4)    VALUE "Run:".
             05 COLUMN 5    PIC X(2)    SOURCE WS-DATE-MM.
             05 COLUMN 7    PIC X       VALUE "/".
             05 COLUMN 8    PIC X(2)    SOURCE WS-DATE-DD.
             05 COLUMN 10   PIC X       VALUE "/".
             05 COLUMN 11   PIC X(4)    SOURCE WS-DATE-YYYY.
             05 COLUMN 16   PIC X(6)    SOURCE WS-TIME.
             05 COLUMN 40   PIC X(16)   VALUE "NEXT PAGE ISSUE".
             05 COLUMN 61   PIC X(4)    VALUE 'Page'.
             05 COLUMN 66   PIC ZZZ9    SOURCE PAGE-COUNTER.
       
          03 LINE NUMBER IS 2.
             05 COLUMN 1     PIC X(08)     VALUE "Region: ".
             05 COLUMN 12    PIC XX        SOURCE TEMP-REGION.
       
          03 LINE NUMBER IS 3.
             05 COLUMN 1   PIC X(21)         VALUE "Location: ".
             05 COLUMN 22  PIC X(7)          SOURCE TEMP-BRANCH.
       
          03 LINE NUMBER IS 4.
             05 COLUMN 1       PIC X(8)     VALUE "Invoice#".
             05 COLUMN 12      PIC X(4)     VALUE "Date".
             05 COLUMN 46      PIC X(6)     VALUE "Order#".
             05 COLUMN 62      PIC X(5)     VALUE "Line#".
             05 COLUMN 69      PIC X(5)     VALUE "Item#".
             05 COLUMN 102     PIC X(6)     VALUE "TX Qty".
             05 COLUMN 114     PIC X(4)     VALUE "Cost".
       
          03 LINE NUMBER IS 5.
             05 COLUMN 1       PIC X(128)   VALUE ALL "-".
       
       01 RPTA-DETAIL-LINE TYPE DETAIL.
             05 LINE PLUS 1.
                07 COLUMN  1   PIC X(8)       GROUP INDICATE 
                                              SOURCE TEMP-INVOICE.
                07 COLUMN 12   PIC X(8)       GROUP INDICATE 
                                              SOURCE TEMP-DATE.
                07 COLUMN 46   PIC X(8)       GROUP INDICATE 
                                              SOURCE TEMP-ORDER.
                07 COLUMN 64   PIC X(3)       SOURCE TEMP-LINE-NO.
                07 COLUMN 69   PIC X(20)      SOURCE TEMP-ITEM.
                07 COLUMN 102  PIC S9(8)      SOURCE TEMP-TX-QTY.
                07 COLUMN 114  PIC ZZZZZZ9.99 SOURCE TEMP-COST.
       
       01 RPTA-INVOICE-FOOTING TYPE CONTROL FOOTING TEMP-INVOICE 
                                 NEXT GROUP PLUS 1.
          03  LINE NUMBER IS PLUS 1.
             05 COLUMN  69        PIC X(15)    VALUE "Invoice Total: ".
             05 COLUMN 101        PIC S9(9)    SUM TEMP-TX-QTY.
             05 COLUMN 113        PIC ZZZZZZZ9.99 SUM TEMP-COST.
       
       01 RPTA-BRANCH-FOOTING TYPE CONTROL FOOTING TEMP-BRANCH 
                                 NEXT GROUP NEXT PAGE.
          03  LINE NUMBER IS PLUS 2.
             05 COLUMN  69        PIC X(15)    VALUE "Branch Total: ".
             05 COLUMN 101        PIC S9(9)    SUM TEMP-TX-QTY.
             05 COLUMN 113        PIC ZZZZZZZ9.99 SUM TEMP-COST.
       
       01 RPTA-REGION-FOOTING TYPE CONTROL FOOTING TEMP-REGION 
                                 NEXT GROUP NEXT PAGE.
          03  LINE NUMBER IS PLUS 2.
             05 COLUMN  69        PIC X(15)    VALUE "Region Total: ".
             05 COLUMN 101        PIC S9(9)    SUM TEMP-TX-QTY.
             05 COLUMN 113        PIC ZZZZZZZ9.99 SUM TEMP-COST.
       
       01 RPTA-FINAL-FOOTING TYPE CONTROL FOOTING FINAL.
          03  LINE NUMBER IS PLUS 2.
             05 COLUMN  69        PIC X(15)    VALUE "Grand Total: ".
             05 COLUMN 101        PIC S9(9)    SUM TEMP-TX-QTY.
             05 COLUMN 113        PIC ZZZZZZZ9.99 SUM TEMP-COST.
       
       PROCEDURE DIVISION.
       
           OPEN INPUT TEMP-FILE.
           OPEN OUTPUT REPORT-FILE.
           
           MOVE "20150225153000000000000" TO WS-CURRENT-DATE.
           
           INITIATE RPTA.
           
           PERFORM PROCESS-DETAIL-LEVEL-REPORT THRU PDLR-EXIT.
           
           TERMINATE RPTA.
           
           CLOSE TEMP-FILE.
           CLOSE REPORT-FILE.
           
           STOP RUN.
       
       
       PROCESS-DETAIL-LEVEL-REPORT.
           PERFORM READ-NEXT-TEMP-REC THRU RNTR-EXIT.
       
           IF TEMP-FILE-EOF EQUALS 1
              GO TO PDLR-EXIT
           END-IF.
       
           GENERATE RPTA-DETAIL-LINE.
       
           GO TO PROCESS-DETAIL-LEVEL-REPORT.
       
       PDLR-EXIT.
           EXIT.
       
       
       READ-NEXT-TEMP-REC.
           READ TEMP-FILE NEXT RECORD
             AT END
                MOVE 1 TO TEMP-FILE-EOF
           END-READ.
       
       RNTR-EXIT.
           EXIT.