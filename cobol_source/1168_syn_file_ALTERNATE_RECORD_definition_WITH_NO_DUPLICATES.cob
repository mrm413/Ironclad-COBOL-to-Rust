IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE
              ASSIGN        "TESTFILE"
              ACCESS        DYNAMIC
              ORGANIZATION  INDEXED
              RECORD KEY    TESTKEY1
              ALTERNATE RECORD KEY TESTKEY2
                               WITH DUPLICATES
              ALTERNATE RECORD KEY TESTKEY3
                               WITH NO DUPLICATES
              .