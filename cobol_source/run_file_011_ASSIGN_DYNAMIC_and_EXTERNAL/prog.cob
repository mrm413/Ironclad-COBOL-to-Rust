IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN whatever
               ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-rec PIC XXX.

       WORKING-STORAGE SECTION.
       01  whatever PIC X(10) VALUE "out.txt".

       PROCEDURE DIVISION.
           OPEN OUTPUT f
           WRITE f-rec FROM "hi"
           CLOSE f
           .