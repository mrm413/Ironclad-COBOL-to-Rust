IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE
              ASSIGN        "TESTFILE"
              ACCESS        DYNAMIC
              ORGANIZATION  INDEXED
              RECORD     KEY  TESTKEY1
              ALTERNATE  KEY  TESTKEY2
              .
       PROCEDURE DIVISION.
           STOP RUN.