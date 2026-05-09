IDENTIFICATION DIVISION.

       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TSPFILE
           ASSIGN TO EXTERNAL TSPFILE
           ORGANIZATION INDEXED ACCESS DYNAMIC
           RECORD KEY IS CM-CUST-NUM

           ALTERNATE RECORD KEY IS SPLIT-KEY2
           SOURCE IS CM-TELEPHONE WITH DUPLICATES

           ALTERNATE RECORD KEY IS SPLIT-KEY3
           SOURCE IS CM-DISK,CM-TAPE WITH DUPLICATES
      *         SUPPRESS WHEN ALL "*"
           FILE STATUS IS CUST-STAT
           .

       DATA  DIVISION.
       FILE SECTION.
       FD  TSPFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSPFL-RECORD.
           05  TSPFL-REC.
           10  CM-CUST-NUM.
             15  CM-CUST-PRE                   PICTURE X(3).
             15  CM-CUST-NNN                   PICTURE X(5).
           10  CM-STATUS                       PICTURE X.
           10  CM-COMPANY                      PICTURE X(25).
           10  CM-ADDRESS-1                    PICTURE X(25).
           10  CM-ADDRESS-2                    PICTURE X(25).
           10  CM-ADDRESS-3                    PICTURE X(25).
           10  CM-TELEPHONE                    PICTURE 9(10).
           10  CM-DP-MGR                       PICTURE X(25).
           10  CM-MACHINE                      PICTURE X(8).
           10  CM-MEMORY                       PICTURE X(4).
           10  CM-DISK                         PICTURE X(8).
           10  CM-TAPE                         PICTURE X(8).
           10  CM-NO-TERMINALS                 PICTURE 9(5).

       WORKING-STORAGE SECTION.

       01  CUST-STAT.
           05  STAT-1 PICTURE 9(4) COMP SYNC.
           05  FILLER REDEFINES STAT-1.
               10  STAT-X1 PIC X COMP-X.
               10  STAT-X2 PIC X COMP-X.
       77  DATA-STAT                      PICTURE XX.
       77  ISAM-STAT                      PICTURE XX.
       77  BYTE-1  PICTURE 9(3).
       77  BYTE-2  PICTURE 9(3).
       78  MAX-SUB           VALUE  16.
       77  SAV-KEY   PIC X(8).

       01  TEST-DATA.

         02  DATA-CUST-NUM-TBL.

           05  FILLER PIC X(8) VALUE "ALP00000".
           05  FILLER PIC X(8) VALUE "BET00000".
           05  FILLER PIC X(8) VALUE "GAM00000".
           05  FILLER PIC X(8) VALUE "DEL00000".
           05  FILLER PIC X(8) VALUE "EPS00000".
           05  FILLER PIC X(8) VALUE "FOR00000".
           05  FILLER PIC X(8) VALUE "GIB00000".
           05  FILLER PIC X(8) VALUE "H&J00000".
           05  FILLER PIC X(8) VALUE "INC00000".
           05  FILLER PIC X(8) VALUE "JOH00000".
           05  FILLER PIC X(8) VALUE "KON00000".
           05  FILLER PIC X(8) VALUE "LEW00000".
           05  FILLER PIC X(8) VALUE "MOR00000".
           05  FILLER PIC X(8) VALUE "NEW00000".
           05  FILLER PIC X(8) VALUE "OLD00000".
           05  FILLER PIC X(8) VALUE "PRE00000".

         02  DATA-CUST-NUM REDEFINES DATA-CUST-NUM-TBL
                                       PIC X(8) OCCURS MAX-SUB.
         02  DATA-COMPANY-TBL.

           05  FILLER PIC X(25) VALUE "ALPHA ELECTRICAL CO. LTD.".
           05  FILLER PIC X(25) VALUE "BETA SHOE MFG. INC.      ".
           05  FILLER PIC X(25) VALUE "GAMMA X-RAY TECHNOLOGY   ".
           05  FILLER PIC X(25) VALUE "DELTA LUGGAGE REPAIRS    ".
           05  FILLER PIC X(25) VALUE "EPSILON EQUIPMENT SUPPLY ".
           05  FILLER PIC X(25) VALUE "FORTUNE COOKIE COMPANY   ".
           05  FILLER PIC X(25) VALUE "GIBRALTER LIFE INSURANCE ".
           05  FILLER PIC X(25) VALUE "H & J PLUMBING SUPPLIES  ".
           05  FILLER PIC X(25) VALUE "INCREMENTAL BACKUP CORP. ".
           05  FILLER PIC X(25) VALUE "JOHNSON BOATING SUPPLIES ".
           05  FILLER PIC X(25) VALUE "KONFLAB PLASTIC PRODUCTS.".
           05  FILLER PIC X(25) VALUE "LEWISTON GRAPHICS LTD.   ".
           05  FILLER PIC X(25) VALUE "MORNINGSIDE CARPENTRY.   ".
           05  FILLER PIC X(25) VALUE "NEW WAVE SURF SHOPS INC. ".
           05  FILLER PIC X(25) VALUE "OLD TYME PIZZA MFG. CO.  ".
           05  FILLER PIC X(25) VALUE "PRESTIGE OFFICE FURNITURE".

         02  DATA-COMPANY  REDEFINES DATA-COMPANY-TBL
                                       PIC X(25) OCCURS MAX-SUB.
         02  DATA-ADDRESS-1-TBL.

           05  FILLER PIC X(25) VALUE "123 MAIN STREET          ".
           05  FILLER PIC X(25) VALUE "1090 2ND AVE. WEST       ".
           05  FILLER PIC X(25) VALUE "1401 JEFFERSON BLVD.     ".
           05  FILLER PIC X(25) VALUE "1620 ARIZONA WAY         ".
           05  FILLER PIC X(25) VALUE "1184 EAST FIRST STREET   ".
           05  FILLER PIC X(25) VALUE "114 JOHN F. KENNEDY AVE. ".
           05  FILLER PIC X(25) VALUE "650 LIBERTY CRESCENT     ".
           05  FILLER PIC X(25) VALUE "77 SUNSET BLVD.          ".
           05  FILLER PIC X(25) VALUE "10908 SANTA MONICA BLVD. ".
           05  FILLER PIC X(25) VALUE "1134 PARIS ROAD          ".
           05  FILLER PIC X(25) VALUE "808 NORTHWEST MAIN ST.   ".
           05  FILLER PIC X(25) VALUE "9904 QUEEN STREET        ".
           05  FILLER PIC X(25) VALUE "1709 DUNDAS CRESCENT W.  ".
           05  FILLER PIC X(25) VALUE "3240 MARIS AVENUE        ".
           05  FILLER PIC X(25) VALUE "1705 WISCONSIN ROAD      ".
           05  FILLER PIC X(25) VALUE "114A MAPLE GROVE         ".

         02  DATA-ADDRESS-1 REDEFINES DATA-ADDRESS-1-TBL
                                       PIC X(25) OCCURS MAX-SUB.
         02  DATA-ADDRESS-2-TBL.

           05  FILLER PIC X(10) VALUE "NEW YORK  ".
           05  FILLER PIC X(10) VALUE "ATLANTA   ".
           05  FILLER PIC X(10) VALUE "WASHINGTON".
           05  FILLER PIC X(10) VALUE "TORONTO   ".
           05  FILLER PIC X(10) VALUE "CALGARY   ".
           05  FILLER PIC X(10) VALUE "SAN DIEGO ".
           05  FILLER PIC X(10) VALUE "LOS RIOS  ".
           05  FILLER PIC X(10) VALUE "MADISON   ".
           05  FILLER PIC X(10) VALUE "WILBUR    ".
           05  FILLER PIC X(10) VALUE "TOPEKA    ".
           05  FILLER PIC X(10) VALUE "SEATTLE   ".
           05  FILLER PIC X(10) VALUE "NEW JERSEY".
           05  FILLER PIC X(10) VALUE "FORT WAYNE".
           05  FILLER PIC X(10) VALUE "COLUMBUS  ".
           05  FILLER PIC X(10) VALUE "RICHMOND  ".
           05  FILLER PIC X(10) VALUE "WHITEPLAIN".

         02  DATA-ADDRESS-2 REDEFINES DATA-ADDRESS-2-TBL
                                       PIC X(10) OCCURS MAX-SUB.
         02  DATA-ADDRESS-3-TBL.

           05  FILLER PIC X(10) VALUE "N.Y.      ".
           05  FILLER PIC X(10) VALUE "GEORGIA   ".
           05  FILLER PIC X(10) VALUE "D.C.      ".
           05  FILLER PIC X(10) VALUE "CANADA    ".
           05  FILLER PIC X(10) VALUE "CANADA    ".
           05  FILLER PIC X(10) VALUE "CALIFORNIA".
           05  FILLER PIC X(10) VALUE "NEW MEXICO".
           05  FILLER PIC X(10) VALUE "WISCONSIN ".
           05  FILLER PIC X(10) VALUE "DELAWARE  ".
           05  FILLER PIC X(10) VALUE "KANSAS    ".
           05  FILLER PIC X(10) VALUE "WASHINGTON".
           05  FILLER PIC X(10) VALUE "N.J.      ".
           05  FILLER PIC X(10) VALUE "COLORADO  ".
           05  FILLER PIC X(10) VALUE "OHIO      ".
           05  FILLER PIC X(10) VALUE "VIRGINIA  ".
           05  FILLER PIC X(10) VALUE "N.Y.      ".

         02  DATA-ADDRESS-3 REDEFINES DATA-ADDRESS-3-TBL
                                       PIC X(10) OCCURS MAX-SUB.
         02  DATA-TELEPHONE-TBL.

           05  FILLER PIC 9(10) VALUE 3131234432.
           05  FILLER PIC 9(10) VALUE 4169898509.
           05  FILLER PIC 9(10) VALUE 8372487274.
           05  FILLER PIC 9(10) VALUE 4169898509.
           05  FILLER PIC 9(10) VALUE 5292398745.
           05  FILLER PIC 9(10) VALUE 8009329492.
           05  FILLER PIC 9(10) VALUE 6456445643.
           05  FILLER PIC 9(10) VALUE 6546456333.
           05  FILLER PIC 9(10) VALUE 3455445444.
           05  FILLER PIC 9(10) VALUE 6456445643.
           05  FILLER PIC 9(10) VALUE 7456434355.
           05  FILLER PIC 9(10) VALUE 6554456433.
           05  FILLER PIC 9(10) VALUE 4169898509.
           05  FILLER PIC 9(10) VALUE 7534587453.
           05  FILLER PIC 9(10) VALUE 8787458374.
           05  FILLER PIC 9(10) VALUE 4169898509.

         02  DATA-TELEPHONE REDEFINES DATA-TELEPHONE-TBL
                                       PIC 9(10) OCCURS MAX-SUB.
         02  DATA-DP-MGR-TBL.

           05  FILLER PIC X(20) VALUE "MR. DAVE HARRIS     ".
           05  FILLER PIC X(20) VALUE "MS. JANICE SILCOX   ".
           05  FILLER PIC X(20) VALUE "MR. ALLAN JONES     ".
           05  FILLER PIC X(20) VALUE "MR. PETER MACKAY    ".
           05  FILLER PIC X(20) VALUE "MRS. DONNA BREWER   ".
           05  FILLER PIC X(20) VALUE "MR. MICHAEL SMYTHE  ".
           05  FILLER PIC X(20) VALUE "MR. D.A. MORRISON   ".
           05  FILLER PIC X(20) VALUE "MR. BRIAN PATTERSON ".
           05  FILLER PIC X(20) VALUE "MR. DARRYL TOWNSEND ".
           05  FILLER PIC X(20) VALUE "MS. VALERIE HARPER  ".
           05  FILLER PIC X(20) VALUE "MR. FRED MILLER     ".
           05  FILLER PIC X(20) VALUE "MR. DONALD FISCHER  ".
           05  FILLER PIC X(20) VALUE "MR. STEVEN YOURDIN  ".
           05  FILLER PIC X(20) VALUE "MS. Goldie Hawn     ".
           05  FILLER PIC X(20) VALUE "MS. ALICE WINSTON   ".
           05  FILLER PIC X(20) VALUE "MR. THOMAS JEFFERSON".

         02  DATA-DP-MGR    REDEFINES DATA-DP-MGR-TBL
                                       PIC X(20) OCCURS MAX-SUB.
         02  DATA-MACHINE-TBL.

           05  FILLER PIC X(8) VALUE "UNI-9030".
           05  FILLER PIC X(8) VALUE "UNI-9040".
           05  FILLER PIC X(8) VALUE "UNI-80/3".
           05  FILLER PIC X(8) VALUE "UNI-80/5".
           05  FILLER PIC X(8) VALUE "UNI-80/6".
           05  FILLER PIC X(8) VALUE "UNI-80/6".
           05  FILLER PIC X(8) VALUE "UNI-80/6".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-80/8".
           05  FILLER PIC X(8) VALUE "UNI-9040".
           05  FILLER PIC X(8) VALUE "UNI-9040".

         02  DATA-MACHINE   REDEFINES DATA-MACHINE-TBL
                                       PIC X(8) OCCURS MAX-SUB.
         02  DATA-NO-TERMINALS-TBL.

           05  FILLER PIC 9(3) COMP-3 VALUE 85.
           05  FILLER PIC 9(3) COMP-3 VALUE 34.
           05  FILLER PIC 9(3) COMP-3 VALUE 75.
           05  FILLER PIC 9(3) COMP-3 VALUE 45.
           05  FILLER PIC 9(3) COMP-3 VALUE 90.
           05  FILLER PIC 9(3) COMP-3 VALUE 107.
           05  FILLER PIC 9(3) COMP-3 VALUE 67.
           05  FILLER PIC 9(3) COMP-3 VALUE 32.
           05  FILLER PIC 9(3) COMP-3 VALUE 16.
           05  FILLER PIC 9(3) COMP-3 VALUE 34.
           05  FILLER PIC 9(3) COMP-3 VALUE 128.
           05  FILLER PIC 9(3) COMP-3 VALUE 64.
           05  FILLER PIC 9(3) COMP-3 VALUE 110.
           05  FILLER PIC 9(3) COMP-3 VALUE 324.
           05  FILLER PIC 9(3) COMP-3 VALUE 124.
           05  FILLER PIC 9(3) COMP-3 VALUE 86.

         02  DATA-NO-TERMINALS REDEFINES DATA-NO-TERMINALS-TBL
                                       PIC 9(3) COMP-3 OCCURS MAX-SUB.

       78  REC-MAX                    VALUE MAX-SUB.
       01  WORK-AREA.
           05  REC-NUM                BINARY-SHORT UNSIGNED VALUE 0.
           05  SUB                    BINARY-SHORT UNSIGNED.
               88  ODD-RECORD         VALUE 1 3 5 7 9 10 11.
               88  NULL-KEY           VALUE 4 5 8 12 14.

           05  TSPFL-KEY              PICTURE X(8).

       PROCEDURE DIVISION.

       MAINFILE.
           DISPLAY "Loading sample data file."
                            UPON CONSOLE.
           PERFORM LOADFILE.
           DISPLAY "Sample data file load complete."
                            UPON CONSOLE.
           PERFORM LIST-FILE.
           PERFORM LIST-PHONE.
           PERFORM DELSEQ-FILE.
           PERFORM LIST-PHONE.
           PERFORM LOADFILE.
           PERFORM LIST-PHONE.
           PERFORM DELPRV-FILE.
           PERFORM LIST-PHONE.
      *    PERFORM DEL-FILE.
           STOP RUN.

       LOADFILE.
           OPEN OUTPUT TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "05"
               DIVIDE STAT-1 BY 256 GIVING BYTE-1 REMAINDER BYTE-2
               DISPLAY "Error " CUST-STAT " " BYTE-1 " " BYTE-2
               " opening 'testisam' file"
                                UPON CONSOLE
               STOP RUN
           END-IF.

           PERFORM 1000-LOAD-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > MAX-SUB.

           CLOSE TSPFILE.

       DEL-FILE.
           DISPLAY "Rewrite sample data file: " CUST-STAT
                            UPON CONSOLE.

           OPEN I-O TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "05"
               DIVIDE STAT-1 BY 256 GIVING BYTE-1 REMAINDER BYTE-2
               DISPLAY "Error " CUST-STAT " " BYTE-1 " " BYTE-2
               " opening 'testisam' file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           MOVE "DEL00000" TO CM-CUST-NUM
           READ TSPFILE
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read lock " CM-CUST-NUM
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           END-IF
           MOVE "INC00000" TO CM-CUST-NUM
           READ TSPFILE
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read lock " CM-CUST-NUM
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           END-IF

           DISPLAY "Sample data file rewrite complete."
                            UPON CONSOLE.
           CLOSE TSPFILE.

       DELSEQ-FILE.
           DISPLAY "Test Read/Delete" UPON CONSOLE.
           MOVE "00" TO  CUST-STAT.
           OPEN I-O TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "05"
               DIVIDE STAT-1 BY 256 GIVING BYTE-1 REMAINDER BYTE-2
               DISPLAY "Error " CUST-STAT " " BYTE-1 " " BYTE-2
               " opening 'testisam' file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           MOVE "INC00000" TO CM-CUST-NUM
           READ TSPFILE
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " random"
           END-IF
           MOVE "ALP00000" TO CM-CUST-NUM
           READ TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " random"
           END-IF
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           ELSE
               DISPLAY "   Read: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           MOVE "PRE00000" TO CM-CUST-NUM
           READ TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " random"
           END-IF
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Expected " CUST-STAT
                       " after delete " CM-CUST-NUM
           ELSE
               DISPLAY "   Read: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF

           MOVE SPACES TO TSPFL-RECORD
           MOVE '4169898509' TO CM-TELEPHONE
           START TSPFILE KEY GREATER THAN OR EQUAL TO SPLIT-KEY2
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           PERFORM 4 TIMES
             READ TSPFILE NEXT RECORD
             IF  CUST-STAT NOT = "00"
             AND CUST-STAT NOT = "02"
                 DISPLAY "Error " CUST-STAT " start " CM-CUST-NUM
             ELSE
                 DISPLAY "Initial: " CM-CUST-NUM " " CM-TELEPHONE
                 IF CM-TELEPHONE = '4169898509'
                    MOVE CM-CUST-NUM TO SAV-KEY
                 END-IF
             END-IF
           END-PERFORM
           MOVE SPACES TO TSPFL-RECORD
           MOVE '4169898509' TO CM-TELEPHONE
           START TSPFILE KEY GREATER THAN OR EQUAL TO SPLIT-KEY2
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " start " CM-CUST-NUM
           ELSE
               DISPLAY "  Start: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           ELSE
               DISPLAY "   Next: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " sequential"
           END-IF
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           ELSE
               DISPLAY "   Next: " CM-CUST-NUM " " CM-TELEPHONE
               IF CM-CUST-NUM NOT = SAV-KEY
                  DISPLAY "Problem! Expected:" SAV-KEY
               END-IF
           END-IF
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           ELSE
               DISPLAY "   Next: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " sequential"
           END-IF

           CLOSE TSPFILE.

       DELPRV-FILE.
           DISPLAY "Read Prev/Delete" UPON CONSOLE.
           MOVE "00" TO  CUST-STAT.
           OPEN I-O TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "05"
               DIVIDE STAT-1 BY 256 GIVING BYTE-1 REMAINDER BYTE-2
               DISPLAY "Error " CUST-STAT " " BYTE-1 " " BYTE-2
               " opening 'testisam' file"
                                UPON CONSOLE
               STOP RUN
           END-IF.

           MOVE SPACES TO TSPFL-RECORD
           MOVE '5292398745' TO CM-TELEPHONE
           START TSPFILE KEY LESS THAN SPLIT-KEY2
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           PERFORM VARYING REC-NUM FROM 1 BY 1
                     UNTIL REC-NUM > 4
             READ TSPFILE PREVIOUS RECORD
             IF  CUST-STAT NOT = "00"
             AND CUST-STAT NOT = "02"
                 DISPLAY "Error " CUST-STAT " start " CM-CUST-NUM
             ELSE
                 DISPLAY REC-NUM " Initial: " CM-CUST-NUM
                         " " CM-TELEPHONE
                 IF REC-NUM = 3
                    MOVE CM-CUST-NUM TO SAV-KEY
                 END-IF
             END-IF
           END-PERFORM
           MOVE SPACES TO TSPFL-RECORD
           MOVE '5292398745' TO CM-TELEPHONE
           START TSPFILE KEY LESS THAN SPLIT-KEY2
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           READ TSPFILE PREVIOUS RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " start " CM-CUST-NUM
           ELSE
               DISPLAY "  Start: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           READ TSPFILE PREVIOUS RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           ELSE
               DISPLAY "   Prev: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " sequential"
           END-IF
           READ TSPFILE PREVIOUS RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read prev " CM-CUST-NUM
               CLOSE TSPFILE
               STOP RUN
           ELSE
               DISPLAY "   Prev: " CM-CUST-NUM " " CM-TELEPHONE
               IF CM-CUST-NUM NOT = SAV-KEY
                  DISPLAY "Problem! Expected:" SAV-KEY
                  CLOSE TSPFILE
                  STOP RUN
               END-IF
           END-IF
           READ TSPFILE PREVIOUS RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read prev " CM-CUST-NUM
           ELSE
               DISPLAY "   Prev: " CM-CUST-NUM " " CM-TELEPHONE
           END-IF
           DELETE TSPFILE
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " delete " CM-CUST-NUM
           ELSE
               DISPLAY " Delete: " CM-CUST-NUM " sequential"
           END-IF

           CLOSE TSPFILE.

       LIST-FILE.
           DISPLAY "List sample data file"
                            UPON CONSOLE.
           MOVE "00" TO  CUST-STAT.
           MOVE 0 TO REC-NUM.
           OPEN I-O TSPFILE
           MOVE "        " TO CM-CUST-NUM
           START TSPFILE KEY GREATER THAN OR EQUAL TO CM-CUST-NUM
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           READ TSPFILE NEXT RECORD
                AT END
                    MOVE "99" TO CUST-STAT
           END-READ.
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " first read " CM-CUST-NUM
           END-IF
           PERFORM UNTIL CUST-STAT NOT = "00"
                      OR REC-NUM > REC-MAX
               DISPLAY "Key: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK
                        "." UPON CONSOLE
               READ TSPFILE NEXT RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
               END-READ
               ADD 1 TO REC-NUM
           END-PERFORM.
           IF CUST-STAT = "99"
               DISPLAY "Hit End of File" UPON CONSOLE
           END-IF.
           CLOSE TSPFILE.

       LIST-PHONE.
           DISPLAY "List sample data file by Phone"
                            UPON CONSOLE.
           MOVE "00" TO  CUST-STAT.
           MOVE 0 TO REC-NUM.
           OPEN I-O TSPFILE
           MOVE SPACES TO TSPFL-RECORD
           START TSPFILE KEY GREATER THAN OR EQUAL TO SPLIT-KEY2
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " read " CM-CUST-NUM
           END-IF
           READ TSPFILE NEXT RECORD
                AT END
                    MOVE "99" TO CUST-STAT
           END-READ.
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " first read " CM-CUST-NUM
           END-IF
           PERFORM UNTIL CUST-STAT NOT = "00"
                     AND CUST-STAT NOT = "02"
               DISPLAY "Ph=" CM-TELEPHONE
                       " Key: " CM-CUST-NUM " is " CM-COMPANY
                       "." UPON CONSOLE
               READ TSPFILE NEXT RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
               END-READ
               ADD 1 TO REC-NUM
           END-PERFORM.
           IF CUST-STAT = "99"
               DISPLAY "Hit End of File" UPON CONSOLE
           END-IF.
           CLOSE TSPFILE.

      *---------------------------------------------------------------*
      *         LOAD A RECORD FROM DATA TABLES                        *
      *---------------------------------------------------------------*

       1000-LOAD-RECORD.

           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE DATA-CUST-NUM      (SUB)     TO CM-CUST-NUM.
           MOVE CM-CUST-NUM                  TO TSPFL-KEY.
           MOVE DATA-COMPANY       (SUB)     TO CM-COMPANY.
           MOVE DATA-ADDRESS-1     (SUB)     TO CM-ADDRESS-1.
           MOVE DATA-ADDRESS-2     (SUB)     TO CM-ADDRESS-2.
           MOVE DATA-ADDRESS-3     (SUB)     TO CM-ADDRESS-3.
           MOVE DATA-TELEPHONE     (SUB)     TO CM-TELEPHONE.
           MOVE DATA-DP-MGR        (SUB)     TO CM-DP-MGR.
           MOVE DATA-MACHINE       (SUB)     TO CM-MACHINE.
           MOVE DATA-NO-TERMINALS  (SUB)     TO CM-NO-TERMINALS.

           IF  ODD-RECORD
               MOVE "8417"                   TO CM-DISK
               MOVE "1600 BPI"               TO CM-TAPE
               MOVE "1MEG"                   TO CM-MEMORY
           ELSE
               MOVE "8470"                   TO CM-DISK
               MOVE "6250 BPI"               TO CM-TAPE
               MOVE "3MEG"                   TO CM-MEMORY.
           IF  NULL-KEY
               MOVE ALL "*"                  TO CM-DISK
               MOVE ALL "*"                  TO CM-TAPE.

           WRITE TSPFL-RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "WRITE: " TSPFL-KEY ", Status: "
                       CUST-STAT UPON CONSOLE
           END-IF.