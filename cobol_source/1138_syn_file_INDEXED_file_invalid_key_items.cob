IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-SOME ASSIGN TO 'FILE-TEST'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD    KEY IS TEST-P2
                        ALTERNATE KEY IS TEST-P1
                        ALTERNATE KEY IS TEST-P3.
       SELECT TEST-FILE ASSIGN TO 'FILE-TEST2'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD    KEY IS TEST-P1
                        ALTERNATE KEY IS TEST-P4
                        ALTERNATE KEY IS NOT-THERE
                        ALTERNATE KEY IS SOME-REC.
       SELECT TEST-MORE ASSIGN TO 'FILE-TEST-EXT'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD KEY    IS NOT-HERE-KEY
                           SOURCE     IS NOT-IN-FILE1
                                         NOT-IN-FILE2.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-SOME.
       01  SOME-REC  PIC X(20).
       FD TEST-FILE.
       01  TEST-REC.
           05 TEST-P1   PIC X(4).
           05 FILLER    PIC X(4).
           05 TEST-P4   PIC X(4).
       FD TEST-MORE.
       01  MORE-REC.
           05 MORE-DATA PIC X(4).
       WORKING-STORAGE  SECTION.
       77  TEST-P2   PIC S9(4) COMP.
       77  TEST-P3   PIC S9(5) COMP-3.
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.