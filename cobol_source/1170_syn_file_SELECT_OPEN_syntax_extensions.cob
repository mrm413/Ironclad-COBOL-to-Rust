IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE1
              ASSIGN        "TESTFILE1"
      *>      WITH ENCRYPTION    shift/reduce conflict ?
              ORGANIZATION  INDEXED
              ACCESS        DYNAMIC
              RECORD KEY    TESTKEY-1P1
                 WITH DUPLICATES
              ALTERNATE RECORD KEY TESTKEY-1P2
                 WITH NO DUPLICATES
              LOCK EXCLUSIVE MASS-UPDATE
              .
       SELECT TEST-FILE2
              ASSIGN        "TESTFILE2"
      *>      ENCRYPTION         shift/reduce conflict ?
              ORGANIZATION  INDEXED
              ACCESS        DYNAMIC
              RECORD KEY    TESTKEY-2P1
                 WITH NO DUPLICATES
              ALTERNATE RECORD KEY TESTKEY-2P2
                 WITH DUPLICATES
              .
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE1.
       01  TEST-REC1.
           03  TESTKEY-1P1 PIC X(4).
           03  TESTKEY-1P2 PIC 9(4).
           03  ENCRYPTION  PIC X(4).
       FD  TEST-FILE2.
       01  TEST-REC2.
           03  TESTKEY-2P1 PIC X(4).
           03  ALLOWING    PIC X(4).
           03  TESTKEY-2P2 PIC 9(4).
       PROCEDURE DIVISION.
           OPEN EXCLUSIVE INPUT TEST-FILE2
           CLOSE TEST-FILE2
           OPEN I-O TEST-FILE1 TEST-FILE2 ALLOWING UPDATERS
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 ALLOWING UPDATERS
           CLOSE TEST-FILE1
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 ALLOWING READERS
           CLOSE TEST-FILE1
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 ALLOWING WRITERS
           CLOSE TEST-FILE1
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 ALLOWING ALL
           CLOSE TEST-FILE1
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 ALLOWING NO
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 ALLOWING NO OTHERS
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 FOR LOCK
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 LOCK
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 BULK-ADDITION
           CLOSE TEST-FILE1
           OPEN I-O TEST-FILE1 MASS-UPDATE
           CLOSE TEST-FILE1
      *
           STOP RUN.