IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE1
              ASSIGN         "TESTFILE"
              ACCESS         DYNAMIC
              ORGANIZATION   INDEXED
              RECORD KEY     TESTKEY-P1 OF TEST-REC1
              ALTERNATE RECORD KEY
                 TEST1KEY2 = TESTKEY-P2 OF TEST-REC1,
                             TESTKEY-P3 OF TEST-REC1
                 WITH DUPLICATES
              .
       SELECT TEST-FILE2
              ASSIGN         "TESTFILE"
              ACCESS         DYNAMIC
              ORGANIZATION   INDEXED
              RECORD KEY     TESTKEY-P1 OF TEST-REC2
              ALTERNATE RECORD KEY
                 TEST2KEY2 SOURCE IS TESTKEY-P2 OF TEST-REC2,
                                     TESTKEY-P3 OF TEST-REC2
                 WITH DUPLICATES
                 .
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE1.
       01  TEST-REC1.
           03  TESTKEY-P1 PIC X(4).
           03  TESTKEY-P2 PIC 9(4).
           03  TESTDATA   PIC X(4).
           03  TESTKEY-P3 PIC X(4).
       FD  TEST-FILE2.
       01  TEST-REC2.
           03  TESTKEY-P1 PIC X(4).
           03  TESTKEY-P2 PIC 9(4).
           03  TESTDATA   PIC X(4).
           03  TESTKEY-P3 PIC X(4).
       PROCEDURE DIVISION.
           STOP RUN.