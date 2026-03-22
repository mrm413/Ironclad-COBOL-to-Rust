IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT    DIVISION.
       CONFIGURATION  SECTION.
       INPUT-OUTPUT   SECTION.
       FILE-CONTROL.

       SELECT PRINT-FILE ASSIGN TO "SUM.TXT"
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA          DIVISION.
       FILE          SECTION.
       FD  PRINT-FILE
           REPORT IS REPORT-1.
      *> --------------------------------------------------------------
       WORKING-STORAGE SECTION.
      *>---------------------------------------------------------------

       01   WS-IN-REC.

                05  WS-STUDENT-NAME           PIC  X(8).
                05  WS-BOOK-PAY               PIC  999V99.
                05  WS-TUTION-PAY             PIC  999V99.
                05  WS-TRANSPORT-PAY          PIC  999V99.

      *>===============================================================
          REPORT  SECTION.

           RD  REPORT-1
               CONTROLS ARE     FINAL
               PAGE     LIMIT   IS 21
               LINE     LIMIT   IS 71
               FIRST    DETAIL  IS 08
               LAST     DETAIL  IS 18
               FOOTING          IS 20
              .
      *>---------------------------------------------------------------
           01  PAGE-HEADING
               TYPE PAGE HEADING.
               02 LINE 01.
                  03 COLUMN 1        VALUE "PAGE HEADING".

           01  REPORT-LINE
               TYPE DETAIL.
               02 LINE PLUS 1.
                03 COLUMN 1        PIC X(13)     VALUE "Detail:".
                03 COLUMN 36       PIC $999.99 SOURCE WS-TUTION-PAY.
                03 COLUMN 47       PIC $999.99 SOURCE WS-BOOK-PAY.
                03 COLUMN 58       PIC $999.99 SOURCE WS-TRANSPORT-PAY.

          01 FINAL-FOOTING TYPE CONTROL FOOTING FINAL.

             02 LINE PLUS 1.
               03 COLUMN 1          PIC X(13)     VALUE "TOTALS     :".
               03 FSM-1 COLUMN 34   PIC $9(5).99  SUM WS-TUTION-PAY.
               03 FSM-2 COLUMN 45   PIC $9(5).99  SUM WS-BOOK-PAY.
               03 FSM-3 COLUMN 56   PIC $9(5).99  SUM WS-TRANSPORT-PAY.


       PROCEDURE DIVISION.
       DECLARATIVES.

       BEFORE-DETAIL1  SECTION.
           USE BEFORE REPORTING REPORT-LINE.

           DISPLAY "BEFORE DETAIL - SHOULD DISPLAY"
           DISPLAY "==============================".

       BEFORE-FINAL1   SECTION.
           USE BEFORE REPORTING FINAL-FOOTING.

       CALC-GRAND-SUM-AND-AVERAGE.

           DISPLAY "BEFORE FINAL - SHOULD DISPLAY".
       END DECLARATIVES.


           OPEN OUTPUT PRINT-FILE

           INITIATE REPORT-1

           MOVE 105 TO WS-TRANSPORT-PAY, WS-BOOK-PAY, WS-TUTION-PAY.
           GENERATE REPORT-LINE

           MOVE 106 TO WS-TRANSPORT-PAY, WS-BOOK-PAY, WS-TUTION-PAY.
           GENERATE REPORT-LINE

           TERMINATE REPORT-1

           CLOSE PRINT-FILE.

           STOP RUN.