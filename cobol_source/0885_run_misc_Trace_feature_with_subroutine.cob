IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL TSPFILE
           ASSIGN TO "testisam"
           ORGANIZATION INDEXED ACCESS DYNAMIC
           RECORD KEY IS CM-CUST-NUM
           ALTERNATE RECORD KEY IS CM-TELEPHONE WITH DUPLICATES
           ALTERNATE RECORD KEY IS CM-DISK WITH DUPLICATES
           FILE STATUS IS CUST-STAT.

           SELECT TSTFILE
           ASSIGN TO "testisam"
           ORGANIZATION INDEXED ACCESS DYNAMIC
           RECORD KEY IS TS-CUST-NUM
           ALTERNATE RECORD KEY IS TS-TELEPHONE WITH DUPLICATES
           ALTERNATE RECORD KEY IS TS-DISK WITH DUPLICATES
           FILE STATUS IS CUST-STAT.

           SELECT FLATFILE
           ASSIGN EXTERNAL RELFIX
           ORGANIZATION RELATIVE
           ACCESS IS RANDOM RELATIVE KEY IS REC-NUM
           FILE STATUS IS CUST-STAT.

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

       FD  TSTFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSTFL-RECORD.
           05  TSTFL-REC.
           10  TS-CUST-NUM                     PICTURE X(8).
           10  TS-STATUS                       PICTURE X.
           10  TS-COMPANY                      PICTURE X(25).
           10  TS-ADDRESS-1                    PICTURE X(25).
           10  TS-ADDRESS-2                    PICTURE X(25).
           10  TS-ADDRESS-3                    PICTURE X(25).
           10  TS-TELEPHONE                    PICTURE 9(10).
           10  TS-DP-MGR                       PICTURE X(25).
           10  TS-MACHINE                      PICTURE X(8).
           10  TS-MEMORY                       PICTURE X(4).
           10  TS-DISK                         PICTURE X(8).
           10  TS-TAPE                         PICTURE X(8).

       FD  FLATFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSP2-RECORD.
           10  C2-CUST-NUM                     PICTURE X(8).
           10  C2-COMPANY                      PICTURE X(25).
           10  C2-DISK                         PICTURE X(8).
           10  C2-NO-TERMINALS                 PICTURE 9(4) COMP-4.
           10  C2-PK-DATE                      PICTURE S9(14) COMP-3.

       WORKING-STORAGE SECTION.

       01  CUST-STAT.
           05  FILLER PICTURE XX.
       77  MAX-SUB           VALUE  16         PICTURE 9(5) COMP SYNC.
       77  CALL-NUM          VALUE  00         PICTURE 99.

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
                                       PIC X(8) OCCURS 16.
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
                                       PIC X(25) OCCURS 16.
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
                                       PIC X(25) OCCURS 16.
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
                                       PIC X(10) OCCURS 16.
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
                                       PIC X(10) OCCURS 16.
         02  DATA-TELEPHONE-TBL.

           05  FILLER PIC 9(10) VALUE 3131234432.
           05  FILLER PIC 9(10) VALUE 4082938498.
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
                                       PIC 9(10) OCCURS 16.
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
                                       PIC X(20) OCCURS 16.
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
                                       PIC X(8) OCCURS 16.
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
                                       PIC 9(3) COMP-3 OCCURS 16.

       01  WORK-AREA.
           05  REC-NUM                         PICTURE 9(6) VALUE 0.
           05  REC-MAX                         PICTURE 9(6) VALUE 10.
           05  SUB                             PICTURE 9(4) COMP SYNC.
               88  ODD-RECORD                  VALUE 1 3 5 7 9 10 11.

           05  TSPFL-KEY                       PICTURE X(8).

       PROCEDURE DIVISION.

       MAINFILE.
           OPEN OUTPUT TSPFILE
           CLOSE TSPFILE.

           OPEN I-O TSPFILE
           MOVE '99' TO CUST-STAT
           READ  TSPFILE NEXT RECORD WITH NO LOCK
           IF CUST-STAT NOT = "10"
               DISPLAY "Error " CUST-STAT " on read of empty file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           MOVE LOW-VALUES                     TO TSPFL-RECORD.
           START TSPFILE KEY GREATER THAN CM-CUST-NUM
           IF CUST-STAT NOT = "23"
               DISPLAY "Error " CUST-STAT " starting empty file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           READ  TSPFILE NEXT RECORD WITH NO LOCK
           IF CUST-STAT NOT = "46"
               DISPLAY "Error " CUST-STAT " start/read of empty file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           DISPLAY "OK: Operations on empty file"
           CLOSE TSPFILE.

           PERFORM LOADFILE.
           PERFORM LISTFILE.



      *> check that multiple empty lines are handled correctly







           STOP RUN.

       LOADFILE.
           DISPLAY "Loading sample data file."
                            UPON CONSOLE.

           OPEN OUTPUT TSPFILE
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT
               " opening 'testisam' file" UPON CONSOLE
               STOP RUN
           END-IF.

           PERFORM 1000-LOAD-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > MAX-SUB.

           DISPLAY "Sample data file load complete."
                            UPON CONSOLE.
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

           WRITE TSPFL-RECORD.
           IF CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Load - Key: " TSPFL-KEY ", Status: " CUST-STAT
                                 UPON CONSOLE.

       LISTFILE.
           DISPLAY "LIST SAMPLE FILE" UPON CONSOLE.
           OPEN INPUT TSTFILE
           MOVE SPACES                       TO TSTFL-RECORD.
           MOVE "PRE00000" TO CM-CUST-NUM.
           START TSTFILE KEY GREATER THAN OR EQUAL TO TS-CUST-NUM
           READ  TSTFILE NEXT RECORD
           READ  TSTFILE NEXT RECORD
           CLOSE TSTFILE.

           MOVE ZERO TO REC-NUM
           OPEN INPUT TSPFILE
           IF CUST-STAT NOT = "00"
               DISPLAY "ERROR " CUST-STAT " OPENING INPUT FILE"
                                             UPON CONSOLE
               STOP RUN
           END-IF.
           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE "PRE00000" TO CM-CUST-NUM.
           START TSPFILE KEY GREATER THAN OR EQUAL TO CM-CUST-NUM
           READ  TSPFILE NEXT RECORD
           READ  TSPFILE NEXT RECORD

           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE "DEL00000" TO CM-CUST-NUM.
           START TSPFILE KEY GREATER THAN CM-CUST-NUM
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " starting file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           READ  TSPFILE NEXT RECORD WITH NO LOCK
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " on 1st read of file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           PERFORM UNTIL CUST-STAT NOT = "00"  *> no WITH AFTER for trace check
                      OR REC-NUM > REC-MAX
               DISPLAY "Key: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
               CALL "callsub" USING CALL-NUM
               READ TSPFILE NEXT RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
               END-READ
               ADD 1 TO REC-NUM
           END-PERFORM
           IF CUST-STAT = "99"
               DISPLAY "Hit End of File: " CALL-NUM UPON CONSOLE
           ELSE
               DISPLAY "Stop read after: " CALL-NUM UPON CONSOLE
           END-IF.

           DISPLAY "LIST SAMPLE FILE DESCENDING" UPON CONSOLE.
           MOVE ZERO TO REC-NUM
           START TSPFILE KEY LESS THAN CM-CUST-NUM
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " starting file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           READ  TSPFILE PREVIOUS RECORD WITH NO LOCK
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " on 1st read of file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           PERFORM  WITH TEST AFTER  UNTIL CUST-STAT NOT = "00"
                      OR REC-NUM > REC-MAX
               DISPLAY "Key: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
               READ TSPFILE PREVIOUS RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
               END-READ
               ADD 1 TO REC-NUM
           END-PERFORM.

           CLOSE TSPFILE.

           OPEN I-O TSPFILE.
           MOVE SPACES                       TO TSPFL-RECORD.
           MOVE DATA-CUST-NUM      (2)       TO CM-CUST-NUM.
           MOVE 'X'                          TO CM-CUST-NUM (5:1).
           READ TSPFILE KEY IS CM-CUST-NUM
           IF  CUST-STAT NOT = "23"
               DISPLAY "Error " CUST-STAT " instead of 23."
                                UPON CONSOLE
           END-IF.
           MOVE DATA-CUST-NUM      (2)       TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (2)       TO CM-COMPANY.
           READ TSPFILE KEY IS CM-CUST-NUM
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " on primary read ."
                                UPON CONSOLE
           ELSE
               DISPLAY "Got: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
           END-IF.
           READ TSPFILE NEXT RECORD
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " on next read"
                                UPON CONSOLE
           ELSE
               DISPLAY "Nxt: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
           END-IF.
           MOVE DATA-TELEPHONE     (7)       TO CM-TELEPHONE.
           MOVE DATA-MACHINE       (7)       TO CM-MACHINE.
           READ TSPFILE KEY IS CM-TELEPHONE
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " instead of 23"
                                UPON CONSOLE
           ELSE
               DISPLAY "Ky2: " CM-CUST-NUM " is " CM-COMPANY
                        " Mach=" CM-MACHINE "."
                         UPON CONSOLE
           END-IF.
           WRITE TSPFL-RECORD
           IF  CUST-STAT NOT = "22"
               DISPLAY "Error " CUST-STAT " instead of 22"
                                UPON CONSOLE
           ELSE
               DISPLAY "  Write: " CM-CUST-NUM " got 22 as expected"
                         UPON CONSOLE
           END-IF.
           MOVE DATA-CUST-NUM      (3)       TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (3)       TO CM-COMPANY.
           READ TSPFILE KEY IS CM-CUST-NUM
           DISPLAY "   Read: " CM-CUST-NUM " got "
                         CUST-STAT " as expected "
                         CM-NO-TERMINALS " terminals"
                         UPON CONSOLE.
           ADD 5 TO CM-NO-TERMINALS
           REWRITE TSPFL-RECORD
           IF  CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " instead of 00"
                                UPON CONSOLE
           ELSE

               DISPLAY "ReWrite: " CM-CUST-NUM " got "
                       CUST-STAT " as expected "
                       CM-NO-TERMINALS " terminals"
                       UPON CONSOLE
           END-IF.
           MOVE DATA-CUST-NUM      (2)       TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (2)       TO CM-COMPANY.
           READ TSPFILE KEY IS CM-CUST-NUM
           DISPLAY "   Read: " CM-CUST-NUM " got "
                         CUST-STAT " as expected "
                         CM-NO-TERMINALS " terminals"
                         UPON CONSOLE.
           MOVE DATA-CUST-NUM      (3)       TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (3)       TO CM-COMPANY.
           REWRITE TSPFL-RECORD
           IF  CUST-STAT NOT = "02"
           AND CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " instead of 00/02"
                                UPON CONSOLE
           ELSE
               DISPLAY "ReWrite: " CM-CUST-NUM " got "
                       "00/02 as expected"
                        UPON CONSOLE
           END-IF
           MOVE DATA-CUST-NUM      (6)       TO CM-CUST-NUM.
           MOVE DATA-COMPANY       (6)       TO CM-COMPANY.
           READ TSPFILE KEY IS CM-CUST-NUM
           MOVE DATA-TELEPHONE     (7)       TO CM-TELEPHONE.
           MOVE DATA-MACHINE       (7)       TO CM-MACHINE.
           REWRITE TSPFL-RECORD
           IF  CUST-STAT NOT = "02"
           AND CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " instead of 00/02"
                                UPON CONSOLE
           ELSE
               DISPLAY "ReWrite: " CM-CUST-NUM " got "
                       "00/02 as expected"
                       UPON CONSOLE
           END-IF
           DELETE TSPFILE
           CLOSE TSPFILE.

       LOADFLAT.
           OPEN OUTPUT FLATFILE.
           PERFORM FLAT-RECORD
                        VARYING SUB FROM 1 BY 1
                          UNTIL SUB > MAX-SUB
                             OR SUB > 5.
           CLOSE FLATFILE.
           OPEN INPUT FLATFILE.
           MOVE 3 TO REC-NUM
           READ FLATFILE
           MOVE 999 TO REC-NUM
           READ FLATFILE
           CLOSE FLATFILE.

       FLAT-RECORD.

           MOVE SPACES                       TO TSP2-RECORD.
           MOVE SUB                          TO REC-NUM.
           MOVE DATA-CUST-NUM      (SUB)     TO C2-CUST-NUM.
           MOVE DATA-COMPANY       (SUB)     TO C2-COMPANY.
           MOVE DATA-NO-TERMINALS  (SUB)     TO C2-NO-TERMINALS.
           MOVE 20070319                     TO C2-PK-DATE.
           IF  ODD-RECORD
               MOVE "8417"                   TO C2-DISK
           ELSE
               MOVE "8470"                   TO C2-DISK.
           WRITE TSP2-RECORD.