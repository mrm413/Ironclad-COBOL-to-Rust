IDENTIFICATION DIVISION.
       PROGRAM-ID. prog2.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT my-file
               ASSIGN TO "somefile"
               ORGANIZATION IS RELATIVE
               RELATIVE KEY IS my-key.

       DATA DIVISION.
       FILE SECTION.
       FD my-file EXTERNAL.
       01 two-record    PIC X(80).

       WORKING-STORAGE SECTION.
       01  my-key PIC 9.

       PROCEDURE DIVISION.
           WRITE two-record
           GOBACK.