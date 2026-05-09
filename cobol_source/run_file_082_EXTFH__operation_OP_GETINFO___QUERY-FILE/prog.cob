IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL TSPFILE
           ASSIGN TO FCD-FILENAME
           ORGANIZATION INDEXED ACCESS DYNAMIC
           RECORD KEY IS CM-CUST-NUM
           ALTERNATE RECORD KEY IS CM-TELEPHONE WITH DUPLICATES
           ALTERNATE RECORD KEY IS SPLIT-KEY3
           SOURCE IS CM-DISK,CM-DP-MGR,CM-MACHINE WITH DUPLICATES
                SUPPRESS WHEN ALL "*"
           FILE STATUS IS CUST-STAT .

       DATA DIVISION.
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

       01  I                       PIC 99.
       01  K                       PIC 99.

       01  CUST-STAT               PIC X(2) VALUE SPACES.
       01  WS-FCD-DDNAME           PIC X(8) VALUE SPACES.
       01  WS-FCD-PTR              POINTER   VALUE NULL.

       01  ACTION-CODE                PIC X(2).
          78  OP-OPEN-INPUT           VALUE x"fa00".
          78  OP-OPEN-OUTPUT          VALUE x"fa01".
          78  OP-OPEN-I-O             VALUE x"fa02".
          78  OP-WRITE                VALUE x"faf3".
          78  OP-RELEASE              VALUE x"faf3".
          78  OP-REWRITE              VALUE x"faf4".
          78  OP-READ-NEXT            VALUE x"faf5".
          78  OP-START-EQUAL          VALUE x"fae9".
          78  OP-CLOSE                VALUE x"fa80".
          78  OP-QUERY-FILE           VALUE x"0006".

       01  FCD-FILENAME               PIC X(80) value "testisam".
       01  FCD-RECORD                 PIC X(512) VALUE SPACES.

       01  FCD-MAP.
           COPY 'xfhfcd3.cpy'.

       01  KEY-DEF.
           03 KDB-LEN             PIC 9(4) COMP-X.
           03 FILLER              PIC X(4).
           03 KEY-NKEYS           PIC 9(4) COMP-X.
           03 FILLER              PIC X(6).
           03 KEY-DEFS OCCURS 16 TIMES.
               05 KEY-COUNT       PIC XX   COMP-X.
               05 KEY-OFFSET      PIC XX   COMP-X.
               05 KEY-FLAGS       PIC X    COMP-X.
               05 KEY-COMPRESSION PIC X    COMP-X.
               05 KEY-SPARSE      PIC X    COMP-X.
               05 FILLER          PIC X(9).
           03 FILLER              PIC X(128).

       LINKAGE SECTION.
       01  KEY-INF.
           03 KEY-DESC            PIC X COMP-X.
           03 KEY-TYPE            PIC X COMP-X.
           03 KEY-POS             PIC X(4) COMP-X.
           03 KEY-LEN             PIC X(4) COMP-X.
      *================================================================*
       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
       000-MAIN.

          DELETE FILE TSPFILE.
          OPEN OUTPUT TSPFILE.
          WRITE TSPFL-RECORD.
          CLOSE TSPFILE.

          SET FCD-KEY-DEF-ADDRESS  TO ADDRESS OF KEY-DEF.
          SET FCD-FILENAME-ADDRESS TO ADDRESS OF FCD-FILENAME.
          MOVE 64 TO FCD-NAME-LENGTH
          MOVE LENGTH OF KEY-DEF TO KDB-LEN.
          SET FCD-RECORD-ADDRESS   TO ADDRESS OF FCD-RECORD.
          MOVE 512 TO FCD-CURRENT-REC-LEN
          MOVE 512 TO FCD-MIN-REC-LENGTH
          MOVE 512 TO FCD-MAX-REC-LENGTH
          MOVE 1 TO FCD-VERSION
          MOVE 255 TO FCD-ORGANIZATION
          MOVE OP-QUERY-FILE TO ACTION-CODE
          PERFORM 800-CALL-EXTFH.
          DISPLAY "Status: " FCD-FILE-STATUS
                  " File: " FCD-FILENAME (1:20) "."
          DISPLAY " Nkeys: " key-nkeys
                  " Recsz: " FCD-MAX-REC-LENGTH.
          DISPLAY "kdblen: " kdb-len.
          PERFORM VARYING I FROM 1 UNTIL I > KEY-NKEYS
             DISPLAY " Index: " i
                     " Parts: " key-count (i)
                     " Offset: " key-offset (i)
                     " Flags: " key-flags (i)
                     " Comp: " key-compression (i)
                     " Sparse: " key-sparse (i)
             SET WS-FCD-PTR TO ADDRESS OF key-def
             SET WS-FCD-PTR UP BY key-offset (i)
             SET ADDRESS OF key-inf TO WS-FCD-PTR
             PERFORM VARYING K FROM 1 UNTIL K > KEY-count (i)
                DISPLAY "   Pos: " key-pos
                        "   Len: " key-len
                        "   Desc: " key-desc
                        " Type: " key-type
                SET WS-FCD-PTR UP BY LENGTH OF key-inf
                SET ADDRESS OF key-inf TO WS-FCD-PTR
             END-PERFORM
          END-PERFORM.

          STOP RUN.

      *----------------------------------------------------------------*
      *    External file handler interface -- all I/O goes through here
      *
        800-CALL-EXTFH.

            CALL "EXTFH" USING ACTION-CODE, FCD-MAP

            IF FCD-STATUS-KEY-1 = "9" AND FCD-BINARY = 199
               MOVE "10" TO FCD-FILE-STATUS
            END-IF
            .