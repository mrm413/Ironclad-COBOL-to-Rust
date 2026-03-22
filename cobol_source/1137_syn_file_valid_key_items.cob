IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-SOME ASSIGN TO 'FILE-TEST'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD    KEY IS TEST-P2 IN TEST-SOME
                        ALTERNATE KEY IS TEST-P3 IN TEST-SOME.
       SELECT TEST-FILE ASSIGN TO 'FILE-TEST2'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD    KEY IS TEST-P1
                        ALTERNATE KEY IS TEST-P4.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-SOME.
       01  SOME-REC.
           05  TEST-P2   PIC S9(4) COMP.
           05  TEST-P3   PIC S9(5) COMP-3.
       FD TEST-FILE.
       01  TEST-REC.
           05 TEST-P1   PIC X(4).
           05 FILLER    PIC X(4).
           05 TEST-P4   PIC X(4).
       WORKING-STORAGE  SECTION.
       01  WS-REC.
           05  TEST-P2   PIC S9(4) COMP.
           05  TEST-P3   PIC S9(5) COMP-3.
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE
           CLOSE TEST-FILE
           OPEN  OUTPUT TEST-SOME
           MOVE CORRESPONDING WS-REC TO SOME-REC
           WRITE SOME-REC
           CLOSE TEST-SOME
      *
           STOP RUN.