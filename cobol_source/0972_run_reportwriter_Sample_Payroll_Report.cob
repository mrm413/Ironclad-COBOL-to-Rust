IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      * ************************************************************* *
      * * MODIFICATIONS:                                              *
      * * CORRECT PARAGRAPH NAME AND GO TO CODING ERRORS.             * 
      * ************************************************************* *
      
      * ************************************************************* *
      * REPORT WRITER EXAMPLE #6.                                     *
      * ************************************************************* *
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
           SELECT PAYROLL-REGISTER-DATA
               ASSIGN TO EXTERNAL DATAIN
                         ORGANIZATION IS LINE SEQUENTIAL.
      
           SELECT REPORT-FILE
               ASSIGN TO EXTERNAL LINE ADVANCING SYSPRINT.
      
       DATA DIVISION.
       FILE SECTION.
      
       FD  PAYROLL-REGISTER-DATA.
      
       01  PAYROLL-REGISTER-RECORD.
           03  PRR-DEPARTMENT-NUMBER   PIC 9(02).
           03  FILLER                  PIC X(01).
           03  PRR-EMPLOYEE-KEY.
               05  PRR-EMPLOYEE-NO     PIC 9(04).
               05  FILLER              PIC X(01).
               05  PRR-GENDER          PIC X(01).
               05  FILLER              PIC X(01).
               05  PRR-EMPLOYEE-NAME   PIC X(20).
           03  FILLER                  PIC X(01).
           03  PRR-PAY-DATE            PIC 9(08).
           03  FILLER                  REDEFINES PRR-PAY-DATE.
               05  PRR-PAY-DATE-YEAR   PIC 9(04).
               05  PRR-PAY-DATE-MONTH  PIC 9(02).
               05  PRR-PAY-DATE-DAY    PIC 9(02).
           03  FILLER                  PIC X(01).
           03  PRR-GROSS-PAY           PIC 9(04)V99.
           03  FILLER                  PIC X(01).
           03  PRR-FICA-WH             PIC 9(03)V99.
           03  FILLER                  PIC X(01).
           03  PRR-FED-WH              PIC 9(03)V99.
           03  FILLER                  PIC X(01).
           03  PRR-MISC-DED            PIC 9(03)V99.
           03  FILLER                  PIC X(01).
           03  PRR-NET-PAY             PIC 9(04)V99.
           03  FILLER                  PIC X(09).
      
       FD  REPORT-FILE
           REPORT IS QUARTERLY-PAY-REGISTER.
      
       WORKING-STORAGE SECTION.
       77  END-OF-FILE-SWITCH          PIC X(1)    VALUE 'N'.
           88  END-OF-FILE                         VALUE 'Y'.
       77  PR-SW                       PIC X(1)    VALUE 'N'.
       77  SUM-FED-WH                  PIC 9(04)V99 VALUE 0.
       77  HI-GROSS                    PIC 9(05) VALUE 2000.
      
       01  WS-EMPLOYEE-KEY.
           03  WS-EMPLOYEE-NUMBER      PIC 9(04).
           03  FILLER                  PIC X(03).
           03  WS-EMPLOYEE-NAME        PIC X(20).
      
       01  WS-PERCENTS-COMPUTED.
           03  WPC-DEPT                OCCURS 6 TIMES
                                       INDEXED BY WPCD-IX.
               05  WPC-PERCENT         OCCURS 5 TIMES
                                       INDEXED BY WPCC-IX
                                       PIC 9(3)V99.
      
       01  DEPARTMENT-TABLE.
           03  FILLER PIC X(17) VALUE '01MANAGEMENT     '.
           03  FILLER PIC X(50) VALUE ZEROS.
           03  FILLER PIC X(17) VALUE '05ADMINISTRATIVE '.
           03  FILLER PIC X(50) VALUE ZEROS.
           03  FILLER PIC X(17) VALUE '10SKILLED NURSING'.
           03  FILLER PIC X(50) VALUE ZEROS.
           03  FILLER PIC X(17) VALUE '15PATIENT SUPPORT'.
           03  FILLER PIC X(50) VALUE ZEROS.
           03  FILLER PIC X(17) VALUE '20HOUSEKEEPING   '.
           03  FILLER PIC X(50) VALUE ZEROS.
           03  FILLER PIC X(17) VALUE '25MAINTENANCE    '.
           03  FILLER PIC X(50) VALUE ZEROS.
       01  FILLER REDEFINES DEPARTMENT-TABLE.
           03  DEPARTMENT-ENTRY      OCCURS 6 TIMES
                                     INDEXED BY DE-IX.
               05  DE-NUMBER         PIC 9(02).
               05  DE-NAME           PIC X(15).
               05  DE-GROSS          PIC 9(08)V99.
               05  DE-FICA           PIC 9(08)V99.
               05  DE-FWT            PIC 9(08)V99.
               05  DE-MISC           PIC 9(08)V99.
               05  DE-NET            PIC 9(08)V99.
      
       REPORT SECTION.
       RD  QUARTERLY-PAY-REGISTER
           CONTROLS ARE FINAL, PRR-DEPARTMENT-NUMBER,
               PRR-EMPLOYEE-KEY
           PAGE LIMIT IS 66 LINES
           HEADING 1
           FIRST DETAIL 7
           LAST DETAIL 60.
      
       01  TYPE PAGE HEADING.
           02  LINE 1.
               03  COLUMN 39   PIC X(13) VALUE 'C E N T U R Y'.
               03  COLUMN 55   PIC X(13) VALUE 'M E D I C A L'.
               03  COLUMN 71   PIC X(11) VALUE 'C E N T E R'.
           02  LINE 2.
               03  COLUMN 35   PIC X(17) VALUE 'Q U A R T E R L Y'.
               03  COLUMN 55   PIC X(13) VALUE 'P A Y R O L L'.
               03  COLUMN 71   PIC X(15) VALUE 'R E G I S T E R'.
               03  COLUMN 111  PIC X(04) VALUE 'PAGE'.
               03  COLUMN 116  PIC ZZZZ9 SOURCE PAGE-COUNTER.
           02  LINE 4.
               03  COLUMN 06   PIC X(9) VALUE ALL '-'.
               03  COLUMN 15   PIC X(28) VALUE
                   ' EMPLOYEE ---------'.
               03  COLUMN 40   PIC X(05) VALUE 'GROSS'.
               03  COLUMN 54   PIC X(04) VALUE 'FICA'.
               03  COLUMN 66   PIC X(07) VALUE 'FED W/H'.
               03  COLUMN 80   PIC X(05) VALUE 'MISC.'.
               03  COLUMN 95   PIC X(03) VALUE 'NET'.
           02  LINE 5.
               03  COLUMN 07   PIC X(02) VALUE 'NO'.
               03  COLUMN 22   PIC X(04) VALUE 'NAME'.
               03  COLUMN 41   PIC X(03) VALUE 'PAY'.
               03  COLUMN 55   PIC X(03) VALUE 'TAX'.
               03  COLUMN 68   PIC X(03) VALUE 'TAX'.
               03  COLUMN 79   PIC X(07) VALUE 'DEDUCT.'.
               03  COLUMN 95   PIC X(03) VALUE 'PAY'.
      
       01  DEPT-HEAD TYPE CONTROL HEADING PRR-DEPARTMENT-NUMBER
           NEXT GROUP + 1.
           02  LINE PLUS 1.
               03  COLUMN 01   PIC X(18) VALUE
                     'DEPARTMENT NUMBER:'.
               03  COLUMN 21   PIC 9(02) SOURCE PRR-DEPARTMENT-NUMBER.
               03  COLUMN 24   PIC X(15) SOURCE DE-NAME (DE-IX).
      
       01  EMPLOYEE-DETAIL TYPE DETAIL.
           02  LINE + 1.
               03  COLUMN 01   PIC X(27) SOURCE PRR-EMPLOYEE-KEY.
               03  COLUMN 30   PIC X(5) VALUE "Hello"
                               PRESENT AFTER NEW PRR-EMPLOYEE-KEY
                                              OR PAGE.
               03  COLUMN 30   PIC X(5) VALUE " ''  "
                               ABSENT AFTER NEW PRR-EMPLOYEE-KEY
                                              OR PAGE.
               03  COLUMN 50   PIC 9(04).99 SOURCE PRR-GROSS-PAY.
               03  COLUMN 60   PIC 9(03).99 SOURCE PRR-FICA-WH.
               03  COLUMN 70   PIC 9(03).99 SOURCE PRR-FED-WH.
               03  COLUMN 80   PIC 9(03).99 SOURCE PRR-MISC-DED.
               03  COLUMN 90   PIC 9(04).99 SOURCE PRR-NET-PAY.
      
       01  EMPL-FOOT TYPE CONTROL FOOTING PRR-EMPLOYEE-KEY.
           02  LINE PLUS 1
                      PRESENT WHEN SUM-FED-WH > 80.00
                  .
               03  COLUMN 06   PIC ZZZ9  SOURCE WS-EMPLOYEE-NUMBER.
               03  COLUMN 14   PIC X(20) SOURCE WS-EMPLOYEE-NAME.
               03  COLUMN 38   PIC $$,$$9.99 SUM PRR-GROSS-PAY.
               03  COLUMN 53   PIC $$$9.99 SUM PRR-FICA-WH.
               03  COLUMN 66   PIC $$$9.99 SUM PRR-FED-WH.
               03  COLUMN 79   PIC $$$9.99 SUM PRR-MISC-DED.
               03  COLUMN 92   PIC $$,$$9.99 SUM PRR-NET-PAY.
      
       01  DEPT-FOOT TYPE CONTROL FOOTING PRR-DEPARTMENT-NUMBER
           NEXT GROUP PLUS 2.
           02  LINE PLUS 2.
               03  COLUMN 14   PIC X(20) VALUE
                   'DEPARTMENT TOTALS'.
               03  DEPT-FOOT-GROSS       COLUMN 38   PIC $$,$$9.99
                                         SUM PRR-GROSS-PAY.
               03  COLUMN 48   PIC X         VALUE '*'.
               03  DEPT-FOOT-FICA        COLUMN 53   PIC $$$9.99
                                         SUM PRR-FICA-WH.
               03  COLUMN 61   PIC X         VALUE '*'.
               03  DEPT-FOOT-FWT         COLUMN 66   PIC $$$9.99
                                         SUM PRR-FED-WH.
               03  COLUMN 74   PIC X         VALUE '*'.
               03  DEPT-FOOT-MISC        COLUMN 79   PIC $$$9.99
                                         SUM PRR-MISC-DED.
               03  COLUMN 87   PIC X         VALUE '*'.
               03  DEPT-FOOT-NET         COLUMN 92   PIC $$,$$9.99
                                         SUM PRR-NET-PAY.
               03  COLUMN 102  PIC X         VALUE '*'.
      
       01  COMP-FOOT TYPE CONTROL FOOTING FINAL.
           02  LINE PLUS 2.
               03  COLUMN 14   PIC X(20) VALUE
                   'COMPANY TOTALS'.
               03  CO-GROSS    COLUMN 37   PIC $$$,$$9.99
                               SUM PRR-GROSS-PAY.
               03  COLUMN 48   PIC XX        VALUE '**'.
               03  CO-FICA     COLUMN 51   PIC $$,$$9.99
                               SUM PRR-FICA-WH.
               03  COLUMN 61   PIC XX        VALUE '**'.
               03  CO-FWT      COLUMN 64   PIC $$,$$9.99
                               SUM PRR-FED-WH.
               03  COLUMN 74   PIC XX        VALUE '**'.
               03  CO-MISC     COLUMN 77   PIC $$,$$9.99
                               SUM PRR-MISC-DED.
               03  COLUMN 87   PIC XX        VALUE '**'.
               03  CO-NET      COLUMN 91   PIC $$$,$$9.99
                               SUM PRR-NET-PAY.
               03  COLUMN 102  PIC XX        VALUE '**'.
      
       01  REPORT-FOOT TYPE REPORT FOOTING.
           02  LINE 1.
               03  COLUMN 39   PIC X(13) VALUE 'C e n t u r y'.
               03  COLUMN 55   PIC X(13) VALUE 'M e d i c a l'.
               03  COLUMN 71   PIC X(11) VALUE 'C e n t e r'.
           02  LINE 2.
               03  COLUMN 35   PIC X(17) VALUE 'Q u a r t e r l y'.
               03  COLUMN 55   PIC X(13) VALUE 'P a y r o l l'.
               03  COLUMN 71   PIC X(15) VALUE 'R e g i s t e r'.
               03  COLUMN 111  PIC X(04) VALUE 'PAGE'.
               03  COLUMN 116  PIC ZZZZ9 SOURCE PAGE-COUNTER.
           02  LINE 4.
               03  COLUMN 40   PIC X(05) VALUE 'GROSS'.
               03  COLUMN 58   PIC X(04) VALUE 'FICA'.
               03  COLUMN 74   PIC X(07) VALUE 'FED W/H'.
               03  COLUMN 92   PIC X(05) VALUE 'MISC.'.
               03  COLUMN 111  PIC X(03) VALUE 'NET'.
           02  LINE 5.
               03  COLUMN 41   PIC X(03) VALUE 'PAY'.
               03  COLUMN 59   PIC X(03) VALUE 'TAX'.
               03  COLUMN 76   PIC X(03) VALUE 'TAX'.
               03  COLUMN 91   PIC X(07) VALUE 'DEDUCT.'.
               03  COLUMN 111  PIC X(03) VALUE 'PAY'.
      
           02  LINE PLUS 2.
               03  COLUMN 05   PIC X(29) VALUE
                   '* * * DEPARTMENT TOTALS * * *'.
           02  LINE PLUS 2.
               03  COLUMN 05   PIC 9(02) SOURCE DE-NUMBER (1).
               03  COLUMN 08   PIC X(15) SOURCE DE-NAME (1).
               03  FILLER      PRESENT WHEN DE-GROSS (1) > HI-GROSS.
                 05  COLUMN 30 PIC X(4) VALUE "High".
               03  COLUMN 38   PIC $$,$$9.99 SOURCE DE-GROSS (1).
               03  COLUMN 48   PIC ZZ9 SOURCE WPC-PERCENT (1 1).
               03  COLUMN 51   PIC X VALUE '%'.
               03  COLUMN 57   PIC $$$9.99   SOURCE DE-FICA (1).
               03  COLUMN 65   PIC ZZ9 SOURCE WPC-PERCENT (1 2).
               03  COLUMN 68   PIC X VALUE '%'.
               03  COLUMN 74   PIC $$$9.99   SOURCE DE-FWT (1).
               03  COLUMN 82   PIC ZZ9 SOURCE WPC-PERCENT (1 3).
               03  COLUMN 85   PIC X VALUE '%'.
               03  COLUMN 91   PIC $$$9.99   SOURCE DE-MISC (1).
               03  COLUMN 99   PIC ZZ9 SOURCE WPC-PERCENT (1 4).
               03  COLUMN 102  PIC X VALUE '%'.
               03  COLUMN 108  PIC $$,$$9.99 SOURCE DE-NET (1).
               03  COLUMN 118  PIC ZZ9 SOURCE WPC-PERCENT (1 5).
               03  COLUMN 121  PIC X VALUE '%'.
               03  FILLER      PRESENT WHEN WPC-PERCENT (1 5) < 15 .
                 05  COLUMN PLUS 2 PIC X(2) VALUE "Lo".
           02  LINE PLUS 2.
               03  COLUMN 05   PIC 9(02) SOURCE DE-NUMBER (2).
               03  COLUMN 08   PIC X(15) SOURCE DE-NAME (2).
               03  FILLER      PRESENT WHEN DE-GROSS (2) > HI-GROSS.
                 05  COLUMN 30 PIC X(4) VALUE "High".
               03  COLUMN 38   PIC $$,$$9.99 SOURCE DE-GROSS (2).
               03  COLUMN 48   PIC ZZ9 SOURCE WPC-PERCENT (2 1).
               03  COLUMN 51   PIC X VALUE '%'.
               03  COLUMN 57   PIC $$$9.99   SOURCE DE-FICA (2).
               03  COLUMN 65   PIC ZZ9 SOURCE WPC-PERCENT (2 2).
               03  COLUMN 68   PIC X VALUE '%'.
               03  COLUMN 74   PIC $$$9.99   SOURCE DE-FWT (2).
               03  COLUMN 82   PIC ZZ9 SOURCE WPC-PERCENT (2 3).
               03  COLUMN 85   PIC X VALUE '%'.
               03  COLUMN 91   PIC $$$9.99   SOURCE DE-MISC (2).
               03  COLUMN 99   PIC ZZ9 SOURCE WPC-PERCENT (2 4).
               03  COLUMN 102  PIC X VALUE '%'.
               03  COLUMN 108  PIC $$,$$9.99 SOURCE DE-NET (2).
               03  COLUMN 118  PIC ZZ9 SOURCE WPC-PERCENT (2 5).
               03  COLUMN 121  PIC X VALUE '%'.
               03  FILLER      PRESENT WHEN WPC-PERCENT (2 5) < 15 .
                 05  COLUMN PLUS 2 PIC X(2) VALUE "Lo".
           02  LINE PLUS 2.
               03  COLUMN 05   PIC 9(02) SOURCE DE-NUMBER (3).
               03  COLUMN 08   PIC X(15) SOURCE DE-NAME (3).
               03  FILLER      PRESENT WHEN DE-GROSS (3) > HI-GROSS.
                 05  COLUMN 30 PIC X(4) VALUE "High".
               03  COLUMN 38   PIC $$,$$9.99 SOURCE DE-GROSS (3).
               03  COLUMN 48   PIC ZZ9 SOURCE WPC-PERCENT (3 1).
               03  COLUMN 51   PIC X VALUE '%'.
               03  COLUMN 57   PIC $$$9.99   SOURCE DE-FICA (3).
               03  COLUMN 65   PIC ZZ9 SOURCE WPC-PERCENT (3 2).
               03  COLUMN 68   PIC X VALUE '%'.
               03  COLUMN 74   PIC $$$9.99   SOURCE DE-FWT (3).
               03  COLUMN 82   PIC ZZ9 SOURCE WPC-PERCENT (3 3).
               03  COLUMN 85   PIC X VALUE '%'.
               03  COLUMN 91   PIC $$$9.99   SOURCE DE-MISC (3).
               03  COLUMN 99   PIC ZZ9 SOURCE WPC-PERCENT (3 4).
               03  COLUMN 102  PIC X VALUE '%'.
               03  COLUMN 108  PIC $$,$$9.99 SOURCE DE-NET (3).
               03  COLUMN 118  PIC ZZ9 SOURCE WPC-PERCENT (3 5).
               03  COLUMN 121  PIC X VALUE '%'.
               03  FILLER      PRESENT WHEN WPC-PERCENT (3 5) < 15 .
                 05  COLUMN PLUS 2 PIC X(2) VALUE "Lo".
           02  LINE PLUS 2.
               03  COLUMN 05   PIC 9(02) SOURCE DE-NUMBER (4).
               03  COLUMN 08   PIC X(15) SOURCE DE-NAME (4).
               03  COLUMN 38   PIC $$,$$9.99 SOURCE DE-GROSS (4).
               03  COLUMN 48   PIC ZZ9 SOURCE WPC-PERCENT (4 1).
               03  COLUMN 51   PIC X VALUE '%'.
               03  COLUMN 57   PIC $$$9.99   SOURCE DE-FICA (4).
               03  COLUMN 65   PIC ZZ9 SOURCE WPC-PERCENT (4 2).
               03  COLUMN 68   PIC X VALUE '%'.
               03  COLUMN 74   PIC $$$9.99   SOURCE DE-FWT (4).
               03  COLUMN 82   PIC ZZ9 SOURCE WPC-PERCENT (4 3).
               03  COLUMN 85   PIC X VALUE '%'.
               03  COLUMN 91   PIC $$$9.99   SOURCE DE-MISC (4).
               03  COLUMN 99   PIC ZZ9 SOURCE WPC-PERCENT (4 4).
               03  COLUMN 102  PIC X VALUE '%'.
               03  COLUMN 108  PIC $$,$$9.99 SOURCE DE-NET (4).
               03  COLUMN 118  PIC ZZ9 SOURCE WPC-PERCENT (4 5).
               03  COLUMN 121  PIC X VALUE '%'.
           02  LINE PLUS 2.
               03  COLUMN 05   PIC 9(02) SOURCE DE-NUMBER (5).
               03  COLUMN 08   PIC X(15) SOURCE DE-NAME (5).
               03  COLUMN 38   PIC $$,$$9.99 SOURCE DE-GROSS (5).
               03  COLUMN 48   PIC ZZ9 SOURCE WPC-PERCENT (5 1).
               03  COLUMN 51   PIC X VALUE '%'.
               03  COLUMN 57   PIC $$$9.99   SOURCE DE-FICA (5).
               03  COLUMN 65   PIC ZZ9 SOURCE WPC-PERCENT (5 2).
               03  COLUMN 68   PIC X VALUE '%'.
               03  COLUMN 74   PIC $$$9.99   SOURCE DE-FWT (5).
               03  COLUMN 82   PIC ZZ9 SOURCE WPC-PERCENT (5 3).
               03  COLUMN 85   PIC X VALUE '%'.
               03  COLUMN 91   PIC $$$9.99   SOURCE DE-MISC (5).
               03  COLUMN 99   PIC ZZ9 SOURCE WPC-PERCENT (5 4).
               03  COLUMN 102  PIC X VALUE '%'.
               03  COLUMN 108  PIC $$,$$9.99 SOURCE DE-NET (5).
               03  COLUMN 118  PIC ZZ9 SOURCE WPC-PERCENT (5 5).
               03  COLUMN 121  PIC X VALUE '%'.
           02  LINE PLUS 2.
               03  COLUMN 05   PIC 9(02) SOURCE DE-NUMBER (6).
               03  COLUMN 08   PIC X(15) SOURCE DE-NAME (6).
               03  COLUMN 38   PIC $$,$$9.99 SOURCE DE-GROSS (6).
               03  COLUMN 48   PIC ZZ9 SOURCE WPC-PERCENT (6 1).
               03  COLUMN 51   PIC X VALUE '%'.
               03  COLUMN 57   PIC $$$9.99   SOURCE DE-FICA (6).
               03  COLUMN 65   PIC ZZ9 SOURCE WPC-PERCENT (6 2).
               03  COLUMN 68   PIC X VALUE '%'.
               03  COLUMN 74   PIC $$$9.99   SOURCE DE-FWT (6).
               03  COLUMN 82   PIC ZZ9 SOURCE WPC-PERCENT (6 3).
               03  COLUMN 85   PIC X VALUE '%'.
               03  COLUMN 91   PIC $$$9.99   SOURCE DE-MISC (6).
               03  COLUMN 99   PIC ZZ9 SOURCE WPC-PERCENT (6 4).
               03  COLUMN 102  PIC X VALUE '%'.
               03  COLUMN 108  PIC $$,$$9.99 SOURCE DE-NET (6).
               03  COLUMN 118  PIC ZZ9 SOURCE WPC-PERCENT (6 5).
               03  COLUMN 121  PIC X VALUE '%'.
           02  LINE PLUS 2.
               03  COLUMN 37   PIC $$$,$$9.99 SOURCE CO-GROSS.
               03  COLUMN 48   PIC X(5) VALUE '100%'.
               03  COLUMN 55   PIC $$,$$9.99  SOURCE CO-FICA.
               03  COLUMN 65   PIC X(5) VALUE '100%'.
               03  COLUMN 72   PIC $$,$$9.99  SOURCE CO-FWT.
               03  COLUMN 82   PIC X(5) VALUE '100%'.
               03  COLUMN 89   PIC $$,$$9.99  SOURCE CO-MISC.
               03  COLUMN 99   PIC X(5) VALUE '100%'.
               03  COLUMN 107  PIC $$$,$$9.99 SOURCE CO-NET.
               03  COLUMN 118  PIC X(5) VALUE '100%'.
      
       PROCEDURE DIVISION.
      
       DECLARATIVES.
      
       DEPT-HEAD-USE SECTION. USE BEFORE REPORTING DEPT-HEAD.
       DEPT-HEAD-PROC.
           SET DE-IX TO +1.
           SEARCH DEPARTMENT-ENTRY
               WHEN DE-NUMBER (DE-IX) = PRR-DEPARTMENT-NUMBER
                   MOVE ZEROS TO DE-GROSS (DE-IX), DE-FICA (DE-IX),
                                 DE-FWT (DE-IX), DE-MISC (DE-IX),
                                 DE-NET (DE-IX).
      
       DEPT-HEAD-EXIT.
           EXIT.
      
       EMPL-FOOT-USE SECTION. USE BEFORE REPORTING EMPL-FOOT.
       EMPL-FOOT-PROC.
           MOVE PRR-EMPLOYEE-KEY TO WS-EMPLOYEE-KEY.
           MOVE 'Y' TO PR-SW.
      
       EMPL-FOOT-EXIT.                                                  
           EXIT.
      
       DEPT-FOOT-USE SECTION. USE BEFORE REPORTING DEPT-FOOT.
       DEPT-FOOT-PROC.
           MOVE DEPT-FOOT-GROSS TO DE-GROSS (DE-IX).
           MOVE DEPT-FOOT-FICA TO DE-FICA (DE-IX).
           MOVE DEPT-FOOT-FWT TO DE-FWT (DE-IX).
           MOVE DEPT-FOOT-MISC TO DE-MISC (DE-IX).
           MOVE DEPT-FOOT-NET TO DE-NET (DE-IX).
      *     SUPPRESS PRINTING.
      
       DEPT-FOOT-EXIT.
           EXIT.
      
       COMP-FOOT-USE SECTION. USE BEFORE REPORTING COMP-FOOT.
       COMP-FOOT-PROC.
           PERFORM COMP-FOOT-CALC
               VARYING WPCD-IX FROM +1 BY +1
               UNTIL WPCD-IX > +6.
           GO TO COMP-FOOT-EXIT.
      
       COMP-FOOT-CALC.
           SET DE-IX TO WPCD-IX.
           SET WPCC-IX TO +1.
           COMPUTE WPC-PERCENT (WPCD-IX WPCC-IX) ROUNDED =
               ((DE-GROSS (DE-IX) / CO-GROSS) * 100) + .5.
           SET WPCC-IX TO +2.
           COMPUTE WPC-PERCENT (WPCD-IX WPCC-IX) ROUNDED =
               ((DE-FICA (DE-IX) / CO-FICA) * 100) + .5.
           SET WPCC-IX TO +3.
           COMPUTE WPC-PERCENT (WPCD-IX WPCC-IX) ROUNDED =
               ((DE-FWT (DE-IX) / CO-FWT) * 100) + .5.
           SET WPCC-IX TO +4.
           COMPUTE WPC-PERCENT (WPCD-IX WPCC-IX) ROUNDED =
               ((DE-MISC (DE-IX) / CO-MISC) * 100) + .5.
           SET WPCC-IX TO +5.
           COMPUTE WPC-PERCENT (WPCD-IX WPCC-IX) ROUNDED =
               ((DE-NET (DE-IX) / CO-NET) * 100) + .5.
      
       COMP-FOOT-EXIT.
           EXIT.
      
       END DECLARATIVES.
      
       000-INITIATE.
      
           OPEN INPUT PAYROLL-REGISTER-DATA,
                OUTPUT REPORT-FILE.
      
           INITIATE QUARTERLY-PAY-REGISTER.
      
           READ PAYROLL-REGISTER-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH.
      
           PERFORM 100-PROCESS-PAYROLL-DATA THRU 199-EXIT
               UNTIL END-OF-FILE.
      
       000-TERMINATE.
           TERMINATE QUARTERLY-PAY-REGISTER.
      
           CLOSE PAYROLL-REGISTER-DATA,
                 REPORT-FILE.
      
           STOP RUN.
      
       100-PROCESS-PAYROLL-DATA.
           ADD PRR-FED-WH TO SUM-FED-WH.
           GENERATE QUARTERLY-PAY-REGISTER.
           IF PR-SW = 'Y'
               MOVE 'N' TO PR-SW
               MOVE ZERO TO SUM-FED-WH.
           READ PAYROLL-REGISTER-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH.
      
       199-EXIT.
           EXIT.