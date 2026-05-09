IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  DBI-RECORD-NAMEST.
           05  FILLER.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ACM            0315 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-MGL            0303 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZBL            0304 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZCC            0308 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZGL            0305 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZOO            0306 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZTR            0307 '.
       01  DBI-RECORD-NAMESR REDEFINES DBI-RECORD-NAMEST.
           05  DBI-RECORD-NAMES
                  OCCURS 7 TIMES
                  INDEXED BY REC-NAME-IDX
                  ASCENDING KEY IS DBI-RECORD-NAME
                  .
             10  DBI-RECORD-NAME PIC X(30).
             10  DBI-RECORD-CODE PIC 9(4).
             10  DBI-RECORD-DIR  PIC X.
       01  REC-NAME   PIC X(30).
       01  DBX-RECORD-NAMEST.
           05  FILLER.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ACM            0315 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-MGL            0303 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZBL            0304 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZCC            0308 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZGL            0305 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZOO            0306 '.
             10 FILLER PIC X(35)
                VALUE 'A-F-GEN-LEDGER-ZTR            0307 '.
       01  DBX-RECORD-NAMESR REDEFINES DBX-RECORD-NAMEST.
           05  DBX-RECORD-NAMES
                  OCCURS 7 TIMES
                  ASCENDING KEY IS DBX-RECORD-NAME
                  INDEXED BY REC-NAME-DBX
                  .
             10  DBX-RECORD-NAME PIC X(30).
             10  DBX-RECORD-CODE PIC 9(4).
             10  DBX-RECORD-DIR  PIC X.

       PROCEDURE DIVISION.
       MAIN.
      *>   "the initial value of an index-name at runtime is undefined"
      *>   Old OpenCOBOL/GnuCOBOL did that as "1"
           SET REC-NAME-IDX          TO 1.
           MOVE 'A-F-GEN-LEDGER-ZGL' TO REC-NAME.
           PERFORM FINDIT.
           MOVE 'JUNK' TO REC-NAME.
           PERFORM FINDIT.
           STOP RUN.

       FINDIT.
           SEARCH DBI-RECORD-NAMES
           AT END
               DISPLAY 'A ' REC-NAME ' is invalid.'
           WHEN REC-NAME = DBI-RECORD-NAME (REC-NAME-IDX)
               DISPLAY 'A ' REC-NAME ' is code '
                         DBI-RECORD-CODE (REC-NAME-IDX) '.'.

           SEARCH DBX-RECORD-NAMES
           AT END
               DISPLAY 'B ' REC-NAME ' is invalid.'
           WHEN REC-NAME = DBX-RECORD-NAME (REC-NAME-DBX)
               DISPLAY 'B ' REC-NAME ' is code '
                         DBX-RECORD-CODE (REC-NAME-DBX) '.'.