IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f1 ASSIGN "f1".
           SELECT f2 ASSIGN "f2".
           SELECT f3 ASSIGN "f3".
           SELECT f4 ASSIGN "f4".

       DATA DIVISION.
       FILE SECTION.
       FD  f1 RECORD VARYING.
       01  f1-rec-1 PIC X.
       01  f1-rec-2 PIC 9.

       FD  f2 RECORD VARYING 1 TO 1.
       01  f2-rec PIC X.

       FD  f3 RECORD 1 TO 1.
       01  f3-rec PIC X.

       FD  f4 RECORD IS VARYING IN SIZE.
       01  f4-rec-1 PIC X.
       01  f4-rec-2 PIC 99.