IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      
      * ************************************************************* *
      * REPORT WRITER EXAMPLE #5.                                     *
      * ************************************************************* *
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
           SELECT SALES-DATA
               ASSIGN TO EXTERNAL DATAIN
                         ORGANIZATION IS LINE SEQUENTIAL.
      
           SELECT REPORT-FILE
               ASSIGN TO EXTERNAL LINE ADVANCING SYSPRINT.
      
       DATA DIVISION.
       FILE SECTION.
      
       FD  SALES-DATA.
      
       01  SALES-RECORD.
           03  SR-SALESMAN-NUMBER      PIC 9(02).
           03  FILLER                  PIC X(01).
           03  SR-DISTRICT-CODE        PIC X(01).
           03  FILLER                  PIC X(01).
           03  SR-SALE-AMOUNT          PIC 9(04)V99.
           03  FILLER                  PIC X(69).
      
       FD  REPORT-FILE
           REPORT IS DISTRICT-SALES-REPORT.
      
       WORKING-STORAGE SECTION.
       77  END-OF-FILE-SWITCH          PIC X(1)    VALUE 'N'.
           88  END-OF-FILE                         VALUE 'Y'.
      
       01  COMMISSION-TABLE.
           02  FILLER                  PIC X(03)   VALUE 'A20'.
           02  FILLER                  PIC X(03)   VALUE 'B18'.
           02  FILLER                  PIC X(03)   VALUE 'C15'.
           02  FILLER                  PIC X(03)   VALUE 'D12'.
           02  FILLER                  PIC X(03)   VALUE 'E10'.
           02  FILLER                  PIC X(03)   VALUE 'F12'.
           02  FILLER                  PIC X(03)   VALUE 'G10'.
           02  FILLER                  PIC X(03)   VALUE 'H08'.
           02  FILLER                  PIC X(03)   VALUE 'J05'.
           02  FILLER                  PIC X(03)   VALUE 'K07'.
       01  FILLER                      REDEFINES COMMISSION-TABLE.
           02  COMMISSION-ENTRY        OCCURS 10 TIMES
                                       INDEXED BY COMMISSION-IX.
               03  CE-DISTRICT         PIC X(01).
               03  CE-RATE             PIC V99.
      
       01  CALCULATED-FIELDS.
           03  WS-COMMISSION           PIC 9(5)V99.
      
       REPORT SECTION.
       RD  DISTRICT-SALES-REPORT
           CONTROLS ARE FINAL, SR-DISTRICT-CODE, SR-SALESMAN-NUMBER
           PAGE LIMIT IS 66 LINES
           HEADING 1
           FIRST DETAIL 5
           LAST DETAIL 58.
      
       01  PAGE-HEAD-GROUP TYPE PAGE HEADING.
           02  LINE 1.
               03  COLUMN 27   PIC X(41) VALUE
                   'D I S T R I C T   S A L E S   R E P O R T'.
               03  COLUMN 90   PIC X(04) VALUE 'PAGE'.
               03  COLUMN 95   PIC ZZZZ9 SOURCE PAGE-COUNTER.
           02  LINE 3.
               03  COLUMN 20   PIC X(26) VALUE
                   '-------- SALESMAN --------'.
               03  COLUMN 54   PIC X(15) VALUE
                   '-- DISTRICT --'.
           02  LINE 4.
               03  COLUMN 20   PIC X(03) VALUE 'NO.'.
               03  COLUMN 28   PIC X(05) VALUE 'SALES'.
               03  COLUMN 37   PIC X(10) VALUE 'COMMISSION'.
               03  COLUMN 54   PIC X(03) VALUE 'NO.'.
               03  COLUMN 61   PIC X(05) VALUE 'SALES'.
      
       01  SALE-DETAIL TYPE DETAIL.
           02  LINE PLUS 1.
               03  COLUMN 01   PIC 99      SOURCE SR-SALESMAN-NUMBER.
               03  COLUMN 04   PIC X       SOURCE SR-DISTRICT-CODE.
               03  COLUMN 06   PIC 9999.99 SOURCE SR-SALE-AMOUNT.
      
       01  SALESMAN-TOTAL TYPE CONTROL FOOTING SR-SALESMAN-NUMBER.
           02  LINE PLUS 1.
               03  COLUMN 20   PIC 99    SOURCE SR-SALESMAN-NUMBER.
               03  ST-SALES-AMT COLUMN 24 PIC $$$,$$9.99 SUM
                       SR-SALE-AMOUNT.
               03  COLUMN 37 PIC $$$,$$9.99 SOURCE WS-COMMISSION.
      
       01  DISTRICT-TOTAL TYPE CONTROL FOOTING SR-DISTRICT-CODE
           NEXT GROUP PLUS 2.
           02  LINE PLUS 1.
               03  COLUMN 54   PIC X     SOURCE SR-DISTRICT-CODE.
               03  COLUMN 58   PIC $$$,$$9.99 SUM ST-SALES-AMT.
      
       01  FINAL-TOTAL TYPE CONTROL FOOTING FINAL.
           02  LINE PLUS 2.
               03  COLUMN 15   PIC X(19) VALUE
                   'MONTHLY TOTAL SALES'.
               03  COLUMN 57   PIC $$$$,$$9.99 SUM ST-SALES-AMT.
               03  COLUMN 69   PIC XX VALUE '**'.
      
       PROCEDURE DIVISION.
      
       DECLARATIVES.
       USE-SALESMAN-TOTAL SECTION. USE BEFORE REPORTING SALESMAN-TOTAL.
       USE-SALESMAN-TOTAL-PROC.
           SET COMMISSION-IX TO 1.
           SEARCH COMMISSION-ENTRY
               AT END
                   MOVE 0.00 TO WS-COMMISSION
               WHEN CE-DISTRICT (COMMISSION-IX) = SR-DISTRICT-CODE
                   COMPUTE WS-COMMISSION ROUNDED =
                       CE-RATE (COMMISSION-IX) * ST-SALES-AMT.
      
       USE-SALESMAN-TOTAL-EXIT.
           EXIT.
      
       END DECLARATIVES.
      
       000-INITIATE.
      
           OPEN INPUT SALES-DATA,
                OUTPUT REPORT-FILE.
      
           INITIATE DISTRICT-SALES-REPORT.
      
           READ SALES-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH
           END-READ.
      
           PERFORM 100-PROCESS-SALES-DATA THRU 199-EXIT
               UNTIL END-OF-FILE.
      
       000-TERMINATE.
           TERMINATE DISTRICT-SALES-REPORT.
      
           CLOSE SALES-DATA,
                 REPORT-FILE.
      
           STOP RUN.
      
       100-PROCESS-SALES-DATA.
           GENERATE DISTRICT-SALES-REPORT.
           READ SALES-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH
           END-READ.
      
       199-EXIT.
           EXIT.