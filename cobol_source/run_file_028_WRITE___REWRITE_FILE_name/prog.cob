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

           SELECT FLATFILE2 ASSIGN EXTERNAL RELFIX
           ORGANIZATION RELATIVE
           ACCESS IS RANDOM RELATIVE KEY IS REC-NUM
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

       FD  FLATFILE2
           BLOCK CONTAINS 5 RECORDS.

       01  TSP2-RECORD.
           10  C2-CUST-NUM                     PICTURE X(8).
           10  C2-COMPANY                      PICTURE X(25).
           10  C2-DISK                         PICTURE X(8).
           10  C2-NO-TERMINALS                 PICTURE 9(4).

       WORKING-STORAGE SECTION.

       78  MAX-SUB           VALUE  6.
       77  CUST-STAT                           PICTURE X(2).
       77  REC-NUM           VALUE  1          BINARY-SHORT UNSIGNED.

       01  TEST-DATA.

         02  DATA-CUST-NUM-TBL.

           05  FILLER PIC X(8) VALUE "ALP00000".
           05  FILLER PIC X(8) VALUE "BET00000".
           05  FILLER PIC X(8) VALUE "DEL00000".
           05  FILLER PIC X(8) VALUE "EPS00000".
           05  FILLER PIC X(8) VALUE "FOR00000".
           05  FILLER PIC X(8) VALUE "GAM00000".

         02  DATA-CUST-NUM REDEFINES DATA-CUST-NUM-TBL
                                       PIC X(8) OCCURS MAX-SUB.
         02  DATA-COMPANY-TBL.

           05  FILLER PIC X(25) VALUE "ALPHA ELECTRICAL CO. LTD.".
           05  FILLER PIC X(25) VALUE "BETA SHOE MFG. INC.      ".
           05  FILLER PIC X(25) VALUE "DELTA LUGGAGE REPAIRS    ".
           05  FILLER PIC X(25) VALUE "EPSILON EQUIPMENT SUPPLY ".
           05  FILLER PIC X(25) VALUE "FORTUNE COOKIE COMPANY   ".
           05  FILLER PIC X(25) VALUE "GAMMA X-RAY TECHNOLOGY   ".
         02  DATA-COMPANY  REDEFINES DATA-COMPANY-TBL
                                       PIC X(25) OCCURS MAX-SUB.
         02  DATA-ADDRESS-2-TBL.

           05  FILLER PIC X(10) VALUE "ATLANTA   ".
           05  FILLER PIC X(10) VALUE "CALGARY   ".
           05  FILLER PIC X(10) VALUE "NEW YORK  ".
           05  FILLER PIC X(10) VALUE "TORONTO   ".
           05  FILLER PIC X(10) VALUE "WASHINGTON".
           05  FILLER PIC X(10) VALUE "WHITEPLAIN".
         02  DATA-ADDRESS   REDEFINES DATA-ADDRESS-2-TBL
                                       PIC X(10) OCCURS MAX-SUB.

         02  DATA-NO-TERMINALS-TBL.

           05  FILLER PIC 9(3) COMP-3 VALUE 10.
           05  FILLER PIC 9(3) COMP-3 VALUE 13.
           05  FILLER PIC 9(3) COMP-3 VALUE 75.
           05  FILLER PIC 9(3) COMP-3 VALUE 10.
           05  FILLER PIC 9(3) COMP-3 VALUE 90.
           05  FILLER PIC 9(3) COMP-3 VALUE 254.

         02  DATA-NO-TERMINALS REDEFINES DATA-NO-TERMINALS-TBL
                                       PIC 9(3) COMP-3 OCCURS MAX-SUB.
       01  WORK-AREA.
           05  SUB                             BINARY-SHORT UNSIGNED.
               88  ODD-RECORD                  VALUE 1 3 5.


       PROCEDURE DIVISION.

           PERFORM LOADFILE.

           OPEN I-O FLATFILE2.
           MOVE 2 TO REC-NUM
           READ FLATFILE2
           DISPLAY "Read    " C2-CUST-NUM " Sts:" CUST-STAT
                   " Trms:" C2-NO-TERMINALS.
           ADD 1 TO C2-NO-TERMINALS
           REWRITE FILE FLATFILE2 FROM TSP2-RECORD
           READ FLATFILE2
           DISPLAY "REWROTE " C2-CUST-NUM " Sts:" CUST-STAT
                   " Trms:" C2-NO-TERMINALS.
           CLOSE FLATFILE2.
           STOP RUN.

       LOADFILE.
           DISPLAY "Loading sample program data file."
                            UPON CONSOLE.

           OPEN OUTPUT FLATFILE.

           PERFORM LOAD-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > MAX-SUB.

           DISPLAY "Sample program data file load complete."
                            UPON CONSOLE.
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
           WRITE FILE FLATFILE FROM TSPFL-RECORD.