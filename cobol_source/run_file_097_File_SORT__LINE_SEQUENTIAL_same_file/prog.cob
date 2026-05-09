IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT SORT-IN   ASSIGN "test.txt"
                        ORGANISATION LINE SEQUENTIAL.
       SELECT SORT-WRK  ASSIGN "dummy".
       DATA             DIVISION.
       FILE             SECTION.
       FD SORT-IN.
       01 IN-REC        PIC X(6).
       SD SORT-WRK.
       01 sort-entry    PIC X(6).
       PROCEDURE        DIVISION.
           SORT SORT-WRK
                ASCENDING sort-entry
                USING  SORT-IN
                GIVING SORT-IN.
             STOP RUN.