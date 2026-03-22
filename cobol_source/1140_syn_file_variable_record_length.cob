IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN TO 'FILE-TEST'
                        ORGANIZATION IS INDEXED
                        ACCESS MODE  IS DYNAMIC
                        RECORD KEY IS TEST-P2
                        ALTERNATE KEY IS TEST-P1
                        ALTERNATE KEY IS TEST-P3.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE
           RECORD IS VARYING IN SIZE
              FROM 2 TO 1250 CHARACTERS.
       01  TEST-REC.
           05 TEST-P1   PIC X(4).
           05 TEST-P2   PIC S9(4) COMP.
           05 TEST-P3   PIC S9(5) COMP-3.
           05 TEST-P4   PIC S9(5).
           05 TEST-P5   PIC S9(2) BINARY.
           05 FILLER    PIC X(129).
       01  RECORDSIZE   PIC X(04).
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.