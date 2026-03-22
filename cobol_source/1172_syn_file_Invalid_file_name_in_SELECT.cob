IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT input ASSIGN "in.txt".

       DATA DIVISION.
       FILE SECTION.
       FD input.
       01 input-rec PIC X.

       PROCEDURE DIVISION.
           CONTINUE
           .