IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN TO "ssad".

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-rec PIC 999999.

       WORKING-STORAGE SECTION.
       01  num PIC 9(6) VALUE 123456.

       PROCEDURE DIVISION.
           OPEN OUTPUT f
           WRITE FILE f FROM zero
           WRITE FILE f FROM 0
           WRITE FILE f FROM "abc"
           REWRITE FILE f FROM zero
           REWRITE FILE f FROM 0
           REWRITE FILE f FROM "abc"
           CLOSE f
           .