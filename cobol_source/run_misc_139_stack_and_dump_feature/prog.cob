IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FLATFILE ASSIGN EXTERNAL RELFIX
           ORGANIZATION RELATIVE
           ACCESS IS SEQUENTIAL RELATIVE KEY IS REC-NUM
           FILE STATUS IS CUST-STAT.

       DATA  DIVISION.
       FILE SECTION.
       FD  FLATFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSPFL-RECORD.
           10  CM-CUST-NUM                     PICTURE X(8).
           10  CM-COMPANY                      PICTURE X(25).
           10  CM-DISK                         PICTURE X(8).
           10  CM-NO-TERMINALS                 PICTURE 9(4).

       WORKING-STORAGE SECTION.
       77  MAX-SUB           VALUE  6          PICTURE 9(4) COMP SYNC.
       77  CUST-STAT                           PICTURE X(2).
       77  REC-NUM           VALUE  1          PICTURE 9(4).
       01  BIN                      PIC 9(9) BINARY VALUE 0.

       01  TEST-DATA.
         02  DATA-CUST-NUM-TBL.
           05  FILLER PIC X(8) VALUE "ALP00000".
           05  FILLER PIC X(8) VALUE "BET00000".
           05  FILLER PIC X(8) VALUE "DEL00000".
           05  FILLER PIC X(8) VALUE "EPS00000".
           05  FILLER PIC X(8) VALUE "FOR00000".
           05  FILLER PIC X(8) VALUE "GAM00000".

         02  DATA-CUST-NUM REDEFINES DATA-CUST-NUM-TBL
                                       PIC X(8) OCCURS 6.
         02  DATA-COMPANY-TBL.
           05  FILLER PIC X(25) VALUE "ALPHA ELECTRICAL CO. LTD.".
           05  FILLER PIC X(25) VALUE "BETA SHOE MFG. INC.      ".
           05  FILLER PIC X(25) VALUE "DELTA LUGGAGE REPAIRS    ".
           05  FILLER PIC X(25) VALUE "EPSILON EQUIPMENT SUPPLY ".
           05  FILLER PIC X(25) VALUE "FORTUNE COOKIE COMPANY   ".
           05  FILLER PIC X(25) VALUE "GAMMA X-RAY TECHNOLOGY   ".
         02  DATA-COMPANY  REDEFINES DATA-COMPANY-TBL
                                       PIC X(25) OCCURS 6.
         02  DATA-ADDRESS-2-TBL.
           05  FILLER PIC X(10) VALUE "ATLANTA   ".
           05  FILLER PIC X(10) VALUE "CALGARY   ".
           05  FILLER PIC X(10) VALUE "NEW YORK  ".
           05  FILLER PIC X(10) VALUE "TORONTO   ".
           05  FILLER PIC X(10) VALUE "WASHINGTON".
           05  FILLER PIC X(10) VALUE "WHITEPLAIN".
         02  DATA-ADDRESS   REDEFINES DATA-ADDRESS-2-TBL
                                       PIC X(10) OCCURS 6.

         02  DATA-NO-TERMINALS-TBL.
           05  FILLER PIC 9(3) COMP-3 VALUE 10.
           05  FILLER PIC 9(3) COMP-3 VALUE 13.
           05  FILLER PIC 9(3) COMP-3 VALUE 75.
           05  FILLER PIC 9(3) COMP-3 VALUE 10.
           05  FILLER PIC 9(3) COMP-3 VALUE 90.
           05  FILLER PIC 9(3) COMP-3 VALUE 254.
         02  DATA-NO-TERMINALS REDEFINES DATA-NO-TERMINALS-TBL
                                       PIC 9(3) COMP-3 OCCURS 6.
       01  WORK-AREA IS EXTERNAL.
           05  SUB                             PICTURE 9(4) COMP SYNC.
               88  ODD-RECORD                  VALUE 1 3 5.
       01  SUMS-NON-STD-OCCURS PIC S9(15)V9(03) OCCURS 8 VALUE -42.345.

       PROCEDURE DIVISION.

           PERFORM LOADFILE.

           OPEN INPUT FLATFILE.
           READ FLATFILE.

       MAIN-100.
           PERFORM CALL-SUB-1.
           PERFORM CALL-SUB-2.
           PERFORM CALL-IT-OMIT.
           STOP RUN.

       LOADFILE.
           OPEN OUTPUT FLATFILE.

           PERFORM LOAD-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > MAX-SUB.

           CLOSE FLATFILE.

       LOAD-RECORD.

           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE DATA-CUST-NUM      (SUB)     TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (SUB)     TO CM-COMPANY.
           MOVE DATA-NO-TERMINALS  (SUB)     TO CM-NO-TERMINALS.
           IF  ODD-RECORD
               MOVE "8417"                   TO CM-DISK
           ELSE
               MOVE "8470"                   TO CM-DISK.
           WRITE TSPFL-RECORD.

       CALL-SUB-1 SECTION.
           CALL "sub1" USING bin, TSPFL-RECORD.

       CALL-SUB-2 SECTION.
           MOVE 4096 TO bin, SUMS-NON-STD-OCCURS (2)
           CALL "sub2" USING bin, TSPFL-RECORD.

       CALL-IT-OMIT SECTION.
           MOVE 5440 TO bin, SUMS-NON-STD-OCCURS (3)
           CALL "sub2" USING bin, TSPFL-RECORD.

           END PROGRAM prog.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. sub1.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ZRO  PIC 9(9) BINARY VALUE 0.
       01  HEXV PIC X  COMP-X.
       01  HEXC REDEFINES HEXV PIC X.

       01 TEST-BASED BASED.
          05 TEST-BASED-SUB PIC X(00000100000).

       01 TEST-ALLOCED BASED.
          05 TEST-ALLOCED-SUB1 PIC X(010).
          05 TEST-ALLOCED-SUB2 PIC 9(006).

       01  IDX PIC 9(9) BINARY VALUE 0.
       01  TSTREC.
         05  TSTDEP  PIC XXX.
         05  TSTX OCCURS 4 TIMES.
           15  TSTG-1 PIC 99.
           15  TSTX-2 PIC XX OCCURS 4 TIMES.
         05  TSTTAIL1  PIC 99.
         05  TSTCOMP3  PIC 9(5) COMP-3.
         05  TSTLONG   PIC X(100).
         05  TSTHEX    PIC X(100).
         05  TSTHEX2   PIC X(60).
         05  TSTTAILX  PIC X(80).

       LINKAGE SECTION.
       01  X  PIC 9(9) BINARY.
       01  TSPFL-RECORD.
           10  CM-CUST-NUM                     PICTURE X(8).
           10  CM-COMPANY                      PICTURE X(25).
           10  CM-DISK                         PICTURE X(8).
           10  CM-NO-TERMINALS                 PICTURE 9(4).

       PROCEDURE DIVISION USING X, OPTIONAL TSPFL-RECORD.
       MAIN-1 SECTION.
            MOVE ALL "X" TO TSTREC.
            MOVE 1 TO TSTG-1 (1).
            MOVE 2 TO TSTG-1 (2).
            MOVE 3 TO TSTG-1 (3).
            MOVE 'A' TO TSTX-2 (1,1).
            MOVE 'B' TO TSTX-2 (2,1).
            MOVE 'C' TO TSTX-2 (3,1).
            MOVE 'xx' TO TSTX-2 (1,4).
            MOVE 'yy' TO TSTX-2 (2,4).
            MOVE 'zz' TO TSTX-2 (3,4).
            MOVE SPACES TO TSTX-2 (1,3).
            MOVE HIGH-VALUES TO TSTX (4).
            MOVE LOW-VALUES TO TSTX-2 (2,3).
            MOVE HIGH-VALUES TO TSTX-2 (3,3).
            MOVE "Quick brown fox jumped over the dog"
              TO TSTLONG, TSTLONG (50:36).
            MOVE "Quicker grey fox jumped the cougar"
              TO TSTHEX (1:35). PERFORM MAIN-2.
       MAIN-2.
            MOVE 17 TO HEXV.
            MOVE HEXC TO TSTHEX (39:1).
            MOVE HEXC TO TSTTAIL1 (2:1).
            MOVE 7 TO HEXV.
            MOVE HEXC TO TSTHEX (47:1).
            MOVE 13 TO HEXV.
            MOVE HEXC TO TSTHEX (59:1).
            MOVE 0 TO HEXV.
            MOVE HEXC TO TSTHEX2 (39:1), TSTHEX2 (10:1).
            MOVE 9 TO HEXV.
            MOVE HEXC TO TSTHEX2 (47:1).
            MOVE '\' TO TSTHEX2 (32:1).
            MOVE 13 TO HEXV.
            MOVE HEXC TO TSTHEX2 (59:1).
            MOVE 'A' TO TSTHEX2 (54:1).
            MOVE LOW-VALUES TO TSTTAILX
            ADD 1 TO X.
            DISPLAY "X is " X.
            ALLOCATE TEST-ALLOCED INITIALIZED.
            COPY cpyabrt.
            IF ADDRESS OF TEST-BASED NOT = NULL
              DISPLAY TEST-BASED-SUB
            END-IF.
            GOBACK.
       END PROGRAM sub1.