IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FLATFILE ASSIGN EXTERNAL SEQFIX
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS IS CUST-STAT .

       DATA  DIVISION.
       FILE SECTION.
       FD  FLATFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSPFL-RECORD.
           10  CM-CUST-NUM                     PICTURE X(8).
           10  CM-COMPANY                      PICTURE X(25).
           10  CM-DISK                         PICTURE X(8).
           10  CM-NO-TERMINALS                 PICTURE 9(5).
           10  CM-PK-DATE                      PICTURE S9(14).
           10  CM-TRAILER                      PICTURE X(52).

       WORKING-STORAGE SECTION.

       78  MAX-SUB           VALUE  6.
       77  CUST-STAT                           PICTURE X(2).

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

           05  FILLER PIC 9(5) VALUE 8240.
           05  FILLER PIC 9(5) VALUE 10.
           05  FILLER PIC 9(5) VALUE 13.
           05  FILLER PIC 9(5) VALUE 65535.
           05  FILLER PIC 9(5) VALUE 10.
           05  FILLER PIC 9(5) VALUE 254.

         02  DATA-NO-TERMINALS REDEFINES DATA-NO-TERMINALS-TBL
                                       PIC 9(5) OCCURS MAX-SUB.
       01  WORK-AREA.
           05  SUB                     USAGE BINARY-SHORT UNSIGNED.
               88  ODD-RECORD          VALUE 1 3 5.


       PROCEDURE DIVISION.

           PERFORM LOADFILE.
           OPEN INPUT FLATFILE.
           DISPLAY "Open Sts:" CUST-STAT
           PERFORM READ-RECORD
           PERFORM READ-RECORD
           PERFORM READ-RECORD
           PERFORM READ-RECORD
           CLOSE FLATFILE.

           OPEN I-O FLATFILE.
           PERFORM READ-RECORD
           MOVE 10 TO CM-NO-TERMINALS
           MOVE "STUFF" TO CM-TRAILER
           REWRITE TSPFL-RECORD
           DISPLAY "REWRITE " CM-CUST-NUM " Sts " CUST-STAT
                   " Trms:" CM-NO-TERMINALS.
           CLOSE FLATFILE.

           OPEN I-O FLATFILE.
           PERFORM READ-RECORD
           PERFORM READ-RECORD
           ADD 1 TO CM-NO-TERMINALS
           REWRITE TSPFL-RECORD
           DISPLAY "REWRITE " CM-CUST-NUM " Sts " CUST-STAT
                   " Trms:" CM-NO-TERMINALS.
           PERFORM READ-RECORD
           CLOSE FLATFILE.

           OPEN I-O FLATFILE.
           READ FLATFILE
           READ FLATFILE
           READ FLATFILE
           READ FLATFILE
           READ FLATFILE
           DISPLAY "Read " CM-CUST-NUM " Sts:" CUST-STAT.
           MOVE 8240 TO CM-NO-TERMINALS
           REWRITE TSPFL-RECORD
           DISPLAY "REWRITE " CM-CUST-NUM " Sts " CUST-STAT
                   " Trms:" CM-NO-TERMINALS.
           CLOSE FLATFILE.

           OPEN INPUT FLATFILE.
           DISPLAY "List back Open Sts:" CUST-STAT
           PERFORM UNTIL CUST-STAT NOT = "00"
             PERFORM READ-RECORD
           END-PERFORM.
           CLOSE FLATFILE.

           OPEN EXTEND FLATFILE.
           PERFORM LOAD-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > 2
           CLOSE FLATFILE.

           OPEN INPUT FLATFILE.
           DISPLAY "List after extend Open Sts:" CUST-STAT
           PERFORM UNTIL CUST-STAT NOT = "00"
             PERFORM READ-RECORD
           END-PERFORM.
           CLOSE FLATFILE.
           STOP RUN RETURNING 0.

       READ-RECORD.
           MOVE SPACES                       TO TSPFL-RECORD.
           READ FLATFILE
           IF CUST-STAT NOT = "00"
             DISPLAY "Read Status: " CUST-STAT
           ELSE
             DISPLAY "Read  " CM-CUST-NUM
                     " Trms:" CM-NO-TERMINALS
           END-IF.

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
           MOVE 20070319                     TO CM-PK-DATE.
           IF SUB = 5
              MOVE "Freddy Kruger"  TO CM-TRAILER.
           IF SUB = 1 OR 4 OR 6
               MOVE -20070319                 TO CM-PK-DATE.

           IF  ODD-RECORD
               MOVE "8417"                   TO CM-DISK
           ELSE
               MOVE "8470"                   TO CM-DISK.
           WRITE TSPFL-RECORD.
           IF CUST-STAT NOT = "00"
               DISPLAY "Write Error " CUST-STAT.