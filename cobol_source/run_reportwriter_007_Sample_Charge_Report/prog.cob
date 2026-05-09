IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      * ************************************************************* *
      * REPORT WRITER EXAMPLE #2.                                     *
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
      
       01  DISCOUNT-TABLE.
           02  FILLER                  PIC 99      VALUE 05.
           02  FILLER                  PIC 99      VALUE 07.
           02  FILLER                  PIC 99      VALUE 10.
           02  FILLER                  PIC 99      VALUE 15.
           02  FILLER                  PIC 99      VALUE 06.
           02  FILLER                  PIC 99      VALUE 22.
           02  FILLER                  PIC 99      VALUE 12.
           02  FILLER                  PIC 99      VALUE 09.
           02  FILLER                  PIC 99      VALUE 20.
       01  FILLER                      REDEFINES DISCOUNT-TABLE.
           02  DISCOUNT                OCCURS 9 TIMES
                                       INDEXED BY DISCOUNT-IX
                                       PIC V99.
      
       01  CALCULATED-FIELDS.
           03  WS-DISCOUNT-AMT         PIC 9(3)V99.
           03  WS-CHARGE-AMT           PIC 9(3)V99.
      
       REPORT SECTION.
       RD  CUSTOMER-REPORT
           CONTROL IS TR-CUSTOMER-NUMBER
           PAGE LIMIT IS 66 LINES
           HEADING 1
           FIRST DETAIL 5
           LAST DETAIL 58.
      
       01  PAGE-HEAD-GROUP TYPE PAGE HEADING.
           02  LINE 1.
               03  COLUMN 27   PIC X(41) VALUE
                   'C U S T O M E R  C H A R G E  R E P O R T'.
               03  COLUMN 90   PIC X(04) VALUE 'PAGE'.
               03  COLUMN 95   PIC ZZZZ9 SOURCE PAGE-COUNTER.
           02  LINE PLUS 2.
               03  COLUMN 01   PIC X(09) VALUE 'CUST. NO.'.
               03  COLUMN 15   PIC X(10) VALUE 'CUST. NAME'.
               03  COLUMN 30   PIC X(05) VALUE 'DEPT.'.
               03  COLUMN 39   PIC X(08) VALUE 'ITEM NO.'.
               03  COLUMN 51   PIC X(09) VALUE 'ITEM COST'.
               03  COLUMN 64   PIC X(08) VALUE 'DISCT. %'.
               03  COLUMN 76   PIC X(11) VALUE 'DISCT. AMT.'.
               03  COLUMN 91   PIC X(06) VALUE 'CHARGE'.
      
       01  CHARGE-DETAIL TYPE DETAIL.
           02  LINE PLUS 1.
               03  COLUMN 03   PIC Z(04) SOURCE TR-CUSTOMER-NUMBER.
               03  COLUMN 10   PIC X(16) SOURCE TR-CUSTOMER-NAME.
               03  COLUMN 32   PIC 9(01) SOURCE TR-ITEM-DEPARTMENT.
               03  COLUMN 40   PIC 9(05) SOURCE TR-ITEM-NUMBER.
               03  COLUMN 51   PIC $$$$.99 SOURCE TR-ITEM-COST.
               03  COLUMN 67   PIC V99 SOURCE DISCOUNT (DISCOUNT-IX).
               03  COLUMN 69   PIC X(01) VALUE '%'.
               03  COLUMN 78   PIC $$$$.99 SOURCE WS-DISCOUNT-AMT.
               03  COLUMN 93   PIC $$$$.99 SOURCE WS-CHARGE-AMT.
      
       01  CUSTOMER-TOTAL TYPE CONTROL FOOTING TR-CUSTOMER-NUMBER
           NEXT GROUP IS PLUS 2.
           02  LINE PLUS 1.
               03  COLUMN 92   PIC $$$$$.99 SUM WS-CHARGE-AMT.
               03  COLUMN 101  PIC X VALUE '*'.
      
       PROCEDURE DIVISION.
      
       000-INITIATE.
      
           OPEN INPUT TRANSACTION-DATA,
                OUTPUT REPORT-FILE.
      
           INITIATE CUSTOMER-REPORT.
      
           READ TRANSACTION-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH
           END-READ.
      
           PERFORM 100-PROCESS-TRANSACTION-DATA THRU 199-EXIT
               UNTIL END-OF-FILE.
      
       000-TERMINATE.
           TERMINATE CUSTOMER-REPORT.
      
           CLOSE TRANSACTION-DATA,
                 REPORT-FILE.
      
           STOP RUN.
      
       100-PROCESS-TRANSACTION-DATA.
           SET DISCOUNT-IX TO TR-ITEM-DEPARTMENT.
           COMPUTE WS-DISCOUNT-AMT ROUNDED =
               TR-ITEM-COST * DISCOUNT (DISCOUNT-IX).
           COMPUTE WS-CHARGE-AMT =
               TR-ITEM-COST - WS-DISCOUNT-AMT.
           GENERATE CHARGE-DETAIL.
           READ TRANSACTION-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH
           END-READ.
      
       199-EXIT.
           EXIT.