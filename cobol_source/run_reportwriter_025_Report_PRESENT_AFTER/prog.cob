IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT IN-FILE   ASSIGN TO EXTERNAL INFILE
                  LINE SEQUENTIAL
                  FILE STATUS IS WS-INPUT-STATUS.

           SELECT OUT-FILE  ASSIGN TO EXTERNAL OREPORT
                  LINE SEQUENTIAL
                  FILE STATUS IS WS-OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  IN-FILE
           RECORDING MODE IS F
           BLOCK 0.

       01  IN-REC.
           05 IN-EMP-NAME                  PIC X(25).
           05 IN-REPORT-PERIOD             PIC X(10).
           05 IN-EMP-USERID                PIC X(10).
           05 IN-BILL-DAYS                 PIC X(3).
           05 IN-SALARY                    PIC 9(8).
           05 FILLER                       PIC X(34).

       FD  OUT-FILE
           RECORDING MODE IS F
           REPORT IS REPORT1.

       01  REP-REC                         PIC X(100).

       WORKING-STORAGE SECTION.
       01  WS-FILE-FLAGS.
           05 WS-INPUT-STATUS              PIC XX.
              88  WS-INPUT-OK                        VALUE '00'.
              88  WS-INPUT-EOF                       VALUE '10'.
           05 WS-OUTPUT-STATUS             PIC XX.
              88  WS-OUTPUT-OK                       VALUE '00'.
      *-----------------------------------------------------------*
      * MISCELLANOUS FIELDS                                       *
      *-----------------------------------------------------------*
       01  WS-MISC.
           05 WS-EMP-NAME                  PIC X(25).
           05 WS-REPORT-PERIOD             PIC X(10).
           05 WS-EMP-USERID                PIC X(10).
           05 WS-BILL-DAYS                 PIC X(3).
           05 WS-SALARY                    PIC 9(8).

       01  WS-MISC-DATE.
           05 WS-DATE                      PIC 9(8) VALUE 20160422.
           05 WS-TIME                      PIC 9(8) VALUE 10550000.
           05 FILLER REDEFINES WS-TIME.
              10 WS-HH                     PIC 99.
              10 WS-MI                     PIC 99.
              10 WS-SS                     PIC 99.
              10 WS-HU                     PIC 99.

       REPORT SECTION.

       RD REPORT1
          PAGE LIMIT IS 65 LINES
          LINE LIMIT 132
          HEADING 1
          CONTROL ARE WS-SALARY.

       01  MAIN-HEADER TYPE IS PAGE HEADING.
           05 LINE 1.
              10 COLUMN CENTER 45  PIC X(35)  VALUE
                 'STARK TECHNOLOGIES MONTHLY REPORT'.

           05 LINE 2.
              10 COLUMN CENTER 45  PIC X(50)  VALUE ALL '-'.

           05 LINE 3.
              10 COLUMN 02  PIC X(14)  VALUE 'REPORT PERIOD:'.
              10 COLUMN 20  PIC 9999/99/99 SOURCE WS-DATE.
              10 COLUMN 32  PIC 99    SOURCE WS-HH.
              10 COLUMN 34  PIC X     VALUE ':'.
              10 COLUMN 35  PIC 99    SOURCE WS-MI.

       01  TYPE IS CONTROL HEADING
                FOR WS-SALARY OR PAGE.
           05 LINE PLUS 2 PRESENT AFTER NEW WS-SALARY.
              10 COLUMN 6   PIC X(9)   VALUE 'EMP NAME:'.
              10 COLUMN 30  PIC X(13)  VALUE 'EMP USERID:'.
              10 COLUMN 60  PIC X(13)  VALUE 'BILLING DAYS'.
              10 COLUMN 80  PIC X(15)  VALUE 'SALARY CREDITED'.
           05 LINE PLUS 1 PRESENT AFTER NEW WS-SALARY.
              10 COLUMN 2   PIC X(100)  VALUE ALL '+'.

       01  DETAIL-1 TYPE DETAIL.
           05 LINE PLUS 1.
              10 COLUMN 6   PIC X(25)  SOURCE WS-EMP-NAME.
              10 COLUMN 30  PIC X(08)  SOURCE WS-EMP-USERID.
              10 COLUMN 60  PIC X(3)   SOURCE WS-BILL-DAYS.
              10 COLUMN 80  PIC Z(7)9  SOURCE WS-SALARY.

       01  REP-FOOTER TYPE DETAIL.
           05 LINE PLUS 2.
              10 COLUMN 2   PIC X(100) VALUE ALL '*'.
           05 LINE PLUS 1.
              10 COLUMN 30  PIC X(23)  VALUE 'END OF SALARY REPORT'.
           05 LINE PLUS 1.
              10 COLUMN 2   PIC X(100) VALUE ALL '*'.

       PROCEDURE DIVISION.

      *    ACCEPT WS-DATE FROM DATE YYYYMMDD.
      *    ACCEPT WS-TIME FROM TIME.

           INITIATE REPORT1

      *    GENERATE MAIN-HEADER

           PERFORM 100-OPEN-FILES
           PERFORM 200-MAIN-PROCESS

           TERMINATE REPORT1

           CLOSE IN-FILE
           CLOSE OUT-FILE
           STOP RUN.

       100-OPEN-FILES.

           OPEN INPUT IN-FILE

           IF WS-INPUT-OK
              CONTINUE
           ELSE
              DISPLAY 'ERROR OPENING INFILE FILE.STATUS = '
                     WS-INPUT-STATUS
              STOP RUN
           END-IF

           OPEN OUTPUT OUT-FILE

           IF WS-OUTPUT-OK
              INITIALIZE REP-REC
           ELSE
              DISPLAY 'ERROR OPENING OREPORT FILE.STATUS = '
                     WS-OUTPUT-STATUS
              STOP RUN
           END-IF.

       200-MAIN-PROCESS.
      *    GENERATE HEADER-1

           PERFORM UNTIL WS-INPUT-EOF
               READ IN-FILE
               MOVE IN-REC  TO WS-MISC
               EVALUATE WS-INPUT-STATUS
                 WHEN '00'
                   GENERATE DETAIL-1
                 WHEN '10'
                   GENERATE REP-FOOTER
                 WHEN OTHER
                   DISPLAY ':ERROR READING INFILE FILE.STATUS = '
                           WS-INPUT-STATUS
                   STOP RUN
               END-EVALUATE
           END-PERFORM.