IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT test-file ASSIGN fpath
                        ORGANIZATION LINE SEQUENTIAL.
       DATA             DIVISION.
       FILE	            SECTION.
       FD  test-file.
       01  test-rec     PIC X(5).
       PROCEDURE        DIVISION.
           OPEN INPUT test-file
           DISPLAY "Hello"
           STOP RUN.