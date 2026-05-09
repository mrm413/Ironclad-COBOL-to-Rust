IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FLATFILE ASSIGN EXTERNAL RELVAR
           ORGANIZATION RELATIVE
           ACCESS IS SEQUENTIAL
           RELATIVE KEY IS REC-NUM
           FILE STATUS IS CUST-STAT.

       DATA  DIVISION.
       FILE SECTION.
       FD  FLATFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSPFL-RECORD.
           10  CM-CUST-NUM                     PICTURE X(8).
           10  CM-TYPE                         PICTURE X.
           10  CM-COMPANY                      PICTURE X(25).
           10  CM-DISK                         PICTURE X(8).
           10  CM-NO-TERMINALS                 PICTURE 9(4) COMP-4.
           10  CM-PK-DATE                      PICTURE S9(14) COMP-3.
           10  CM-TRAILER                      PICTURE X(251).

       01  TSP2-RECORD.
           10  C2-CUST-NUM                     PICTURE X(8).
           10  C2-TYPE                         PICTURE X.
           10  C2-COMPANY                      PICTURE X(25).
           10  C2-ADDRESS                      PICTURE X(25).
           10  C2-DISK                         PICTURE X(8).
           10  C2-NO-TERMINALS                 PICTURE 9(4) COMP-4.
           10  C2-PK-DATE                      PICTURE S9(14) COMP-3.


       WORKING-STORAGE SECTION.

       78  MAX-SUB           VALUE  6.
       77  CUST-STAT                           PICTURE X(2).
       77  REC-NUM           VALUE  1          BINARY-SHORT UNSIGNED.

       01  TEST-DATA.

         02  DATA-CUST-NUM-TBL.

           05  FILLER PIC X(8) VALUE "ALP00000".
           05  FILLER PIC X(8) VALUE "BET00000".
           05  FILLER PIC X(8) VALUE "GAM00000".
           05  FILLER PIC X(8) VALUE "DEL00000".
           05  FILLER PIC X(8) VALUE "EPS00000".
           05  FILLER PIC X(8) VALUE "FOR00000".

         02  DATA-CUST-NUM REDEFINES DATA-CUST-NUM-TBL
                                       PIC X(8) OCCURS MAX-SUB.
         02  DATA-COMPANY-TBL.

           05  FILLER PIC X(25) VALUE "ALPHA ELECTRICAL CO. LTD.".
           05  FILLER PIC X(25) VALUE "BETA SHOE MFG. INC.      ".
           05  FILLER PIC X(25) VALUE "GAMMA X-RAY TECHNOLOGY   ".
           05  FILLER PIC X(25) VALUE "DELTA LUGGAGE REPAIRS    ".
           05  FILLER PIC X(25) VALUE "EPSILON EQUIPMENT SUPPLY ".
           05  FILLER PIC X(25) VALUE "FORTUNE COOKIE COMPANY   ".
         02  DATA-COMPANY  REDEFINES DATA-COMPANY-TBL
                                       PIC X(25) OCCURS MAX-SUB.
         02  DATA-ADDRESS-2-TBL.

           05  FILLER PIC X(10) VALUE "NEW YORK  ".
           05  FILLER PIC X(10) VALUE "ATLANTA   ".
           05  FILLER PIC X(10) VALUE "WASHINGTON".
           05  FILLER PIC X(10) VALUE "TORONTO   ".
           05  FILLER PIC X(10) VALUE "CALGARY   ".
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
           OPEN INPUT FLATFILE.
           DISPLAY "Initial Re-Read Open Sts:" CUST-STAT
           PERFORM UNTIL CUST-STAT NOT = "00"
               PERFORM READ-RECORD
           END-PERFORM.
           IF CUST-STAT = "30"
               CLOSE FLATFILE
           STOP RUN
           END-IF
           CLOSE FLATFILE.

           OPEN I-O FLATFILE.
           DISPLAY "For Rewrite Open I-O Sts:" CUST-STAT
           PERFORM READ-RECORD
           ADD 1 TO C2-NO-TERMINALS
           REWRITE TSP2-RECORD
           DISPLAY "REWRITE " CM-CUST-NUM " Sts " CUST-STAT
                   " Trms:" C2-NO-TERMINALS.
           CLOSE FLATFILE.

           OPEN I-O FLATFILE.
           DISPLAY "For Rewrite/Delete Open I-O Sts:" CUST-STAT
           PERFORM READ-RECORD
           ADD 1 TO C2-NO-TERMINALS
           REWRITE TSP2-RECORD
           DISPLAY "REWRITE " CM-CUST-NUM " Sts " CUST-STAT
                   " Trms:" C2-NO-TERMINALS.
           PERFORM READ-RECORD
           DELETE FLATFILE
           DISPLAY "DELETE " CM-CUST-NUM " Sts " CUST-STAT.
           CLOSE FLATFILE.

           OPEN INPUT FLATFILE.
           DISPLAY "Re-list Open Sts:" CUST-STAT
           PERFORM UNTIL CUST-STAT NOT = "00"
               PERFORM READ-RECORD
           END-PERFORM.
           CLOSE FLATFILE.

           OPEN EXTEND FLATFILE.
           PERFORM LOAD-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > 2.
           CLOSE FLATFILE.

           OPEN INPUT FLATFILE.
           DISPLAY "Re-list afer Extend Open Sts:" CUST-STAT
           PERFORM UNTIL CUST-STAT NOT = "00"
               PERFORM READ-RECORD
           END-PERFORM.
           CLOSE FLATFILE.
           STOP RUN RETURNING 0.

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

       READ-RECORD.
           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE SPACES                       TO TSP2-RECORD.
           READ FLATFILE
           IF CUST-STAT NOT = "00"
             DISPLAY "Read Status: " CUST-STAT
           ELSE
           IF CM-TYPE = SPACES
             DISPLAY "Read  " CM-CUST-NUM " #:" REC-NUM
                     " Trms:" CM-NO-TERMINALS
           ELSE
             DISPLAY "Read2 " C2-CUST-NUM " #:" REC-NUM
                     " Trms:" C2-NO-TERMINALS
           END-IF.
      *
       LOAD-RECORD.
           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE SPACES                       TO TSP2-RECORD.
           MOVE DATA-CUST-NUM      (SUB)     TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (SUB)     TO CM-COMPANY.
           MOVE DATA-NO-TERMINALS  (SUB)     TO CM-NO-TERMINALS.
           MOVE 20070319                     TO CM-PK-DATE.
           IF SUB = 1 OR 4 OR 6
               MOVE -20070319                 TO CM-PK-DATE.
      *
           IF ODD-RECORD
               MOVE "8417"                   TO C2-DISK
      *        MOVE CM-CUST-NUM              TO C2-CUST-NUM
               MOVE '2'                      TO C2-TYPE
      *        MOVE CM-COMPANY               TO C2-COMPANY
               MOVE CM-PK-DATE               TO C2-PK-DATE
               MOVE CM-NO-TERMINALS          TO C2-NO-TERMINALS
               MOVE DATA-ADDRESS (SUB)       TO C2-ADDRESS
               WRITE TSP2-RECORD
           ELSE
               MOVE "8470"                   TO CM-DISK
               MOVE ' '                      TO CM-TYPE
               WRITE TSPFL-RECORD.