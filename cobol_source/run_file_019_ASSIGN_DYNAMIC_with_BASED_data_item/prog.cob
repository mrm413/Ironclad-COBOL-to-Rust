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
       WORKING-STORAGE  SECTION.
       01  path         BASED PIC X(10).
       01  x            PIC X.
       PROCEDURE        DIVISION CHAINING x.
           IF x NOT = SPACES
              ALLOCATE path
              MOVE "TEST-FILE" TO path
              OPEN INPUT test-file
              FREE path
           ELSE
              OPEN INPUT test-file
           END-IF
           READ test-file   END-READ
           IF test-rec NOT = "hello"
              DISPLAY test-rec END-DISPLAY
           END-IF
           CLOSE test-file
           STOP RUN.