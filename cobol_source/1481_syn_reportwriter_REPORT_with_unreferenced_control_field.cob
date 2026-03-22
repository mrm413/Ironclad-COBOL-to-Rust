IDENTIFICATION  DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT     DIVISION.
       INPUT-OUTPUT    SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN "f.txt".

       DATA            DIVISION.
       FILE            SECTION.
       FD  f           REPORT r.
       01  f-rec       PIC X.

       REPORT          SECTION.
       RD  r.
       01  r0          TYPE DETAIL, PRESENT AFTER NEW f-rec.