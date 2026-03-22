IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE
              ASSIGN        "TESTFILE"
              ACCESS        DYNAMIC
              ORGANIZATION  INDEXED
              RECORD KEY    TESTKEY-P1
              ALTERNATE RECORD KEY TESTKEY-P2
                 WITH DUPLICATES
                 SUPPRESS WHEN ZEROES
              ALTERNATE RECORD KEY TESTKEY-P3
                 WITH DUPLICATES
                 SUPPRESS WHEN SPACES
              ALTERNATE RECORD KEY TESTKEY-P4
                 WITH DUPLICATES
                 SUPPRESS WHEN ALL "A"
              ALTERNATE RECORD KEY TESTKEY-P5
                 WITH DUPLICATES
                 SUPPRESS WHEN ALL SPACES
              .
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE.
       01  TEST-REC.
           03  TESTKEY-P1 PIC X(4).
           03  TESTKEY-P2 PIC 9(4).
           03  TESTDATA   PIC X(4).
           03  TESTKEY-P3 PIC X(4).
           03  TESTKEY-P4 PIC X(4).
           03  TESTKEY-P5 PIC X(4).
       PROCEDURE DIVISION.
           STOP RUN.