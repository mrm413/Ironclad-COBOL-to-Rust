IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT SORT-IN   ASSIGN "SORT-IN".
       SELECT SORT-OUT  ASSIGN "SORT-OUT".
       SELECT SORT-WRK  ASSIGN "SORT-WRK".
       DATA             DIVISION.
       FILE             SECTION.
       FD SORT-IN.
       01 IN-REC        PIC X(100).
       FD SORT-OUT.
       01 OUT-REC       PIC X(100).
       SD SORT-WRK.
       01 WRK-REC       PIC X(100).
       PROCEDURE        DIVISION.
           SORT SORT-WRK
                ASCENDING KEY WRK-REC
                USING  SORT-IN
                GIVING SORT-OUT.
             STOP RUN.