IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog3.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN TO 'FILE-TEST'
                        ORGANIZATION IS SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE
           RECORD CONTAINS  5 TO 10 CHARACTERS.
       01  TEST-REC-1.
           05 FILLER    PIC X(4).
       01  TEST-REC-2.
           05 FILLER    PIC X(50).
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.