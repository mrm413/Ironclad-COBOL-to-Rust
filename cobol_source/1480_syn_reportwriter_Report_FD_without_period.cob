IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       ENVIRONMENT     DIVISION.
       INPUT-OUTPUT    SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN "f.txt".

       DATA            DIVISION.
       FILE            SECTION.
       FD  f           REPORT r