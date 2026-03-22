IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       ENVIRONMENT     DIVISION.
       INPUT-OUTPUT    SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN "f.txt".

       DATA            DIVISION.
       FILE            SECTION.
       FD  f           REPORT r1, r2.
       01  f-rec       PIC XXXXX.

       REPORT          SECTION.
       RD  r1          PAGE LIMIT 1 LINES 1 COLUMNS
                       HEADING f-rec,
                       HEADING f-rec,
                       LINE LIMIT 1.

       RD  r2          PAGE LIMIT 1 COLUMNS
                       HEADING f-rec.