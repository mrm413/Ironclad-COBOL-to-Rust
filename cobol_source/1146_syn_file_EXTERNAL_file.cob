IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT my-file
               ASSIGN TO "somefile"
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD my-file EXTERNAL.
       01 my-record.
           03 my-record-data PIC X(80).

       PROCEDURE DIVISION.
           GOBACK.