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
       01  path         PIC X(10).
       01  x            PIC X.
       PROCEDURE        DIVISION CHAINING x.
           IF X = SPACE
              MOVE SPACES     TO path
           ELSE
              MOVE LOW-VALUES TO path
           END-IF
           OPEN INPUT test-file
           DISPLAY "Hello"
           STOP RUN.