IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

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
       01 my-record.
           03 my-record-data PIC X(80).

       WORKING-STORAGE SECTION.
       01  my-key PIC 9.

       PROCEDURE DIVISION.
           OPEN OUTPUT my-file
           MOVE 'testme' TO my-record
           CALL 'prog2'
           CLOSE my-file
           GOBACK.