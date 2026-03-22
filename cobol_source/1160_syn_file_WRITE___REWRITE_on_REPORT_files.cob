IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN TO "ssad" LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  f REPORT f-rep.
       01  f-rec PIC X(05).

       REPORT SECTION.
       RD  f-rep.
       01  f-rep-line TYPE DE PIC XXX.

       PROCEDURE DIVISION.
           OPEN OUTPUT f
           WRITE FILE f FROM "abc"
           REWRITE FILE f FROM "abc"
           CLOSE f
           .