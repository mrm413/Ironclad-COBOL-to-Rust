IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT test-file ASSIGN path
                        ORGANIZATION LINE SEQUENTIAL
                        FILE STATUS TEST-STAT.
       DATA             DIVISION.
       FILE	            SECTION.
       FD  test-file.
       01  test-rec     PIC X(5).
       WORKING-STORAGE  SECTION.
       01  path         BASED PIC X(10).
       01  test-stat    PIC X(2) VALUE "XX".
       PROCEDURE        DIVISION.
           OPEN INPUT test-file
           IF TEST-STAT NOT = '31'
              DISPLAY 'BAD OPEN, STATUS "' test-stat '"' END-DISPLAY
           END-IF
           READ test-file   END-READ
           IF TEST-STAT NOT = '47'
              DISPLAY 'BAD READ, STATUS "' test-stat '"' END-DISPLAY
           END-IF
           CLOSE test-file
           STOP RUN.