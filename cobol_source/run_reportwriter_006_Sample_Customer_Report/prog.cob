IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      
      * ************************************************************* *
      * REPORT WRITER EXAMPLE #1.                                     *
      * ************************************************************* *
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
           SELECT TRANSACTION-DATA
               ASSIGN TO EXTERNAL DATAIN
                         ORGANIZATION IS LINE SEQUENTIAL.
      
           SELECT REPORT-FILE
               ASSIGN TO EXTERNAL LINE ADVANCING SYSPRINT.
      
       DATA DIVISION.
       FILE SECTION.
      
       FD  TRANSACTION-DATA.
      
       01  TRANSACTION-RECORD.
           03  TR-CUSTOMER-NUMBER      PIC 9(04).
           03  FILLER                  PIC X(01).
           03  TR-CUSTOMER-NAME        PIC X(16).
           03  FILLER                  PIC X(01).
           03  TR-ITEM-NUMBER          PIC 9(05).
           03  FILLER                  REDEFINES TR-ITEM-NUMBER.
               05  TR-ITEM-DEPARTMENT  PIC 9(01).
               05  FILLER              PIC 9(04).
           03  FILLER                  PIC X(01).
           03  TR-ITEM-COST            PIC 9(03)V99.
           03  FILLER                  PIC X(47).
      
       FD  REPORT-FILE
           REPORT IS CUSTOMER-REPORT.
      
       WORKING-STORAGE SECTION.
       77  END-OF-FILE-SWITCH          PIC X(1)    VALUE 'N'.
           88  END-OF-FILE                         VALUE 'Y'.
      
       REPORT SECTION.
       RD  CUSTOMER-REPORT
           PAGE LIMIT IS 66 LINES
           HEADING 1
           FIRST DETAIL 5
           LAST DETAIL 58.
      
       01  PAGE-HEAD-GROUP TYPE PAGE HEADING.
           02  LINE 1.
               03  COLUMN 27   PIC X(41) VALUE
                   'C U S T O M E R  C H A R G E  R E P O R T'.
           02  LINE PLUS 2.
               03  COLUMN 01   PIC X(09) VALUE 'CUST. NO.'.
               03  COLUMN 15   PIC X(10) VALUE 'CUST. NAME'.
               03  COLUMN 30   PIC X(05) VALUE 'DEPT.'.
               03  COLUMN 39   PIC X(08) VALUE 'ITEM NO.'.
               03  COLUMN 51   PIC X(09) VALUE 'ITEM COST'.
      
       01  CHARGE-DETAIL TYPE DETAIL.
           02  LINE PLUS 1.
               03  COLUMN 03   PIC Z(04) SOURCE TR-CUSTOMER-NUMBER.
               03  COLUMN 10   PIC X(16) SOURCE TR-CUSTOMER-NAME.
               03  COLUMN 32   PIC 9(01) SOURCE TR-ITEM-DEPARTMENT.
               03  COLUMN 40   PIC 9(05) SOURCE TR-ITEM-NUMBER.
               03  COLUMN 51   PIC $$$$.99 SOURCE TR-ITEM-COST.
      
       PROCEDURE DIVISION.
      
       000-INITIATE.
      
           OPEN INPUT TRANSACTION-DATA,
                OUTPUT REPORT-FILE.
      
           INITIATE CUSTOMER-REPORT.
      
           READ TRANSACTION-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH.
      *    END-READ.
      
           PERFORM 100-PROCESS-TRANSACTION-DATA THRU 199-EXIT
               UNTIL END-OF-FILE.
      
       000-TERMINATE.
           TERMINATE CUSTOMER-REPORT.
      
           CLOSE TRANSACTION-DATA,
                 REPORT-FILE.
      
           STOP RUN.
      
       100-PROCESS-TRANSACTION-DATA.
           GENERATE CHARGE-DETAIL.
           READ TRANSACTION-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH.
      *    END-READ.
      
       199-EXIT.
           EXIT.