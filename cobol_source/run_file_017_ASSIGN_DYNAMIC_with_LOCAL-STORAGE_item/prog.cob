IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT test-file ASSIGN path
                        ORGANIZATION LINE SEQUENTIAL.
       DATA             DIVISION.
       FILE	            SECTION.
       FD  test-file.
       01  test-rec     PIC X(5).
       LOCAL-STORAGE    SECTION.
       01  path         PIC X(10) VALUE "test.txt".
       PROCEDURE        DIVISION.
           OPEN INPUT test-file
           READ test-file   END-READ
           IF test-rec NOT = "hello"
              DISPLAY test-rec END-DISPLAY
           END-IF
           CLOSE test-file
           STOP RUN.