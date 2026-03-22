IDENTIFICATION DIVISION.

       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

      $set fcdreg
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TSPFILE
           ASSIGN TO "mytstisam"
           ORGANIZATION INDEXED ACCESS DYNAMIC
           RECORD KEY IS PRIME-KEY
           SOURCE IS CM-CUST-NUM

           ALTERNATE RECORD KEY IS SPLIT-KEY2
           SOURCE IS CM-TELEPHONE,CM-MACHINE
      *         WITH DUPLICATES

           ALTERNATE RECORD KEY IS SPLIT-KEY3
           SOURCE IS CM-DISK,CM-TAPE
      *         WITH DUPLICATES
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
       77  BYTE-1  PICTURE 9(3).
       77  BYTE-2  PICTURE 9(3).
       78  MAX-SUB           VALUE  16.
       77  IDX                                 PICTURE 9.
       77  IDX2                                PICTURE 9.
       77  OUT-FILE-NAME                       PICTURE X(9)
           VALUE "myextisam".

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

       01  WORK-AREA.
           05  REC-NUM                         PICTURE 9(2) VALUE 0.
           05  SUB                             BINARY-SHORT UNSIGNED.
               88  ODD-RECORD                  VALUE 1 3 5 7 9 10 11.
               88  NULL-KEY                    VALUE 4 5 8 12 14.

           05  TSPFL-KEY                       PICTURE X(8).
           05  KC-PTR                          USAGE POINTER.

       LINKAGE SECTION.

       01  TSP-FCD.
           COPY "xfhfcd.cpy".

       01 key-def.
           03 kdb-len             pic 9(4) comp-x.
           03 filler              pic x(4).
           03 key-nkeys           pic 9(4) comp-x.
           03 filler              pic x(6).
           03 key-defs occurs 1 to 8 times depending on key-nkeys.
              05 key-count       pic 9(3) comp-x.
              05 key-offset      pic 9(3) comp-x.
              05 key-flags       pic X  comp-x.
              05 key-compression pic X  comp-x.
              05 key-sparse      pic x.
              05 filler          pic x(9).

       01 key-comp.
           03 kc-desc            pic X comp-x.
           03 kc-type            pic X comp-x.
           03 kc-pos             pic 9(9) comp-x.
           03 kc-len             pic 9(9) comp-x.

       01 TSP-FILENAME   PIC X(256).
       PROCEDURE DIVISION.

       MAINFILE.
           SET ADDRESS OF TSP-FCD TO ADDRESS OF FH--FCD OF TSPFILE.
           SET ADDRESS OF KEY-DEF TO ADDRESS OF FH--KEYDEF OF TSPFILE.
           DISPLAY "Other Flags " FCD-OTHER-FLAGS "."
           DISPLAY "File has " key-nkeys " keys."
           DISPLAY "Key def  " kdb-len " bytes."
           SET ADDRESS OF TSP-FILENAME TO FCD-FILENAME-ADDRESS.
           DISPLAY "File assigned is '"
                   TSP-FILENAME (1:FCD-NAME-LENGTH) "'".
           SET FCD-FILENAME-ADDRESS TO ADDRESS OF OUT-FILE-NAME.
           MOVE LENGTH OF OUT-FILE-NAME TO FCD-NAME-LENGTH.
           DISPLAY "*** Dump FCD before changes"
           PERFORM DUMP-FCD.
           MOVE 64 TO KEY-FLAGS (2)
           MOVE 66 TO KEY-FLAGS (3)
           MOVE '*' TO KEY-SPARSE (3)
           DISPLAY "*** Dump FCD after changes"
           PERFORM DUMP-FCD.
           PERFORM LOADFILE.
           PERFORM LISTFILE.
           STOP RUN.

       DUMP-FCD.
           PERFORM VARYING IDX FROM 1 BY 1
                     UNTIL IDX > key-nkeys
             IF key-sparse (idx) < ' '
               MOVE ' ' TO key-sparse (idx)
             END-IF
             DISPLAY "Key" IDX " has " key-count (idx) " parts,"
                     " Offset " key-offset (idx)
                     " Flags " key-flags (idx)
                     " Comp " key-compression (idx)
                     " Sparse " key-sparse (idx) "."
             SET KC-PTR TO ADDRESS OF KEY-DEF
             SET KC-PTR UP BY key-offset (idx)
             PERFORM VARYING IDX2 FROM 1 BY 1
                     UNTIL IDX2 > key-count (idx)
               SET ADDRESS OF KEY-COMP TO KC-PTR
               DISPLAY "      Pos " kc-pos " Len " kc-len
               SET KC-PTR UP BY LENGTH OF KEY-COMP
             END-PERFORM
           END-PERFORM.

       LOADFILE.
           OPEN OUTPUT TSPFILE
           SET ADDRESS OF TSP-FILENAME TO FCD-FILENAME-ADDRESS.
           DISPLAY "Loading sample file '"
                   TSP-FILENAME (1:FCD-NAME-LENGTH) "'"
                            UPON CONSOLE.

           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "05"
               DISPLAY "Error " CUST-STAT " opening '"
                       TSP-FILENAME (1:FCD-NAME-LENGTH) "' file"
                                UPON CONSOLE
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
           IF  NULL-KEY
               MOVE ALL "*"                  TO CM-DISK
               MOVE ALL "*"                  TO CM-TAPE.
           IF  SUB = 1 OR 6
               MOVE "2417"                   TO CM-DISK
               MOVE "549  mmm"               TO CM-TAPE.

           WRITE TSPFL-RECORD
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "WRITE: " TSPFL-KEY ", Status: "
                       CUST-STAT UPON CONSOLE
           END-IF.

       LISTFILE.
           MOVE ZERO TO REC-NUM
           OPEN INPUT TSPFILE
           SET ADDRESS OF TSP-FILENAME TO FCD-FILENAME-ADDRESS.
           DISPLAY "List sample file '"
                   TSP-FILENAME (1:FCD-NAME-LENGTH) "'"
                            UPON CONSOLE.
           IF  CUST-STAT NOT = "00"
               DISPLAY "ERROR " CUST-STAT " OPENING INPUT FILE"
                                             UPON CONSOLE
               IF CUST-STAT (1:1) = "9"
                   DISPLAY "Sub Error " STAT-X2 UPON CONSOLE
               END-IF
               STOP RUN
           END-IF.
           MOVE SPACES                       TO TSPFL-RECORD.
           START TSPFILE KEY GREATER THAN PRIME-KEY
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " starting file"
                                UPON CONSOLE
               IF CUST-STAT (1:1) = "9"
                   DISPLAY "Sub Error " STAT-X2 UPON CONSOLE
               END-IF
               STOP RUN
           END-IF.
           READ  TSPFILE NEXT RECORD WITH NO LOCK
           IF CUST-STAT NOT = "00"
               DISPLAY "Error " CUST-STAT " on 1st read of file"
                                UPON CONSOLE
               IF CUST-STAT (1:1) = "9"
                   DISPLAY "Sub Error " STAT-X2 UPON CONSOLE
               END-IF
               STOP RUN
           END-IF.
           PERFORM UNTIL CUST-STAT NOT = "00"
                      OR REC-NUM > MAX-SUB
               DISPLAY "Key: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
               READ TSPFILE NEXT RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
                END-READ
                ADD 1 TO REC-NUM
           END-PERFORM
           IF CUST-STAT = "99"
               DISPLAY "Hit End of File after " REC-NUM UPON CONSOLE
           END-IF.

           DISPLAY "LIST SAMPLE FILE DESCENDING" UPON CONSOLE.
           MOVE ZERO TO REC-NUM
           MOVE ALL 'Z'                      TO TSPFL-RECORD.
           START TSPFILE KEY LESS THAN PRIME-KEY
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
           PERFORM UNTIL CUST-STAT NOT = "00"
                      OR REC-NUM > MAX-SUB
               DISPLAY "Key: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
               READ TSPFILE PREVIOUS RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
                END-READ
                ADD 1 TO REC-NUM
           END-PERFORM.
           IF CUST-STAT = "99"
               DISPLAY "Hit End of File after " REC-NUM UPON CONSOLE
           END-IF.

           DISPLAY "LIST SAMPLE FILE BY KEY3" UPON CONSOLE.
           MOVE ZERO                         TO REC-NUM
           MOVE SPACES                       TO TSPFL-RECORD.
           START TSPFILE KEY GREATER THAN OR EQUAL TO SPLIT-KEY3
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " starting file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           READ  TSPFILE NEXT RECORD WITH NO LOCK
           IF  CUST-STAT NOT = "00"
           AND CUST-STAT NOT = "02"
               DISPLAY "Error " CUST-STAT " on 1st read of file"
                                UPON CONSOLE
               STOP RUN
           END-IF.
           PERFORM UNTIL (CUST-STAT NOT = "00"
                      AND CUST-STAT NOT = "02")
                      OR REC-NUM > MAX-SUB
               DISPLAY "Key: " CM-CUST-NUM " is " CM-COMPANY
                        " Disk=" CM-DISK "."
                         UPON CONSOLE
               READ TSPFILE NEXT RECORD
                    AT END
                        MOVE "99" TO CUST-STAT
                END-READ
                ADD 1 TO REC-NUM
           END-PERFORM.
           IF CUST-STAT = "99"
               DISPLAY "Hit End of File after " REC-NUM UPON CONSOLE
           END-IF.
           CLOSE TSPFILE.