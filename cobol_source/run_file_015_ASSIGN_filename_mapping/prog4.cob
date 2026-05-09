IDENTIFICATION DIVISION.
       PROGRAM-ID. prog4.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  FILE0 ASSIGN  TO "./nosubhere/MYFILE0"
                   ORGANIZATION  IS LINE SEQUENTIAL
                   FILE STATUS   IS WSFS.
           SELECT  FILE1 ASSIGN  TO "MYFILE1"
                   ORGANIZATION  IS LINE SEQUENTIAL
                   FILE STATUS   IS WSFS.
           SELECT  FILE2 ASSIGN  TO FILENAME
                   ORGANIZATION  IS LINE SEQUENTIAL
                   FILE STATUS   IS WSFS.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE0.
       01  F0REC             PIC X(80).
       FD  FILE1.
       01  F1REC             PIC X(80).
       FD  FILE2.
       01  F2REC             PIC X(80).
       WORKING-STORAGE SECTION.
       77  FILENAME          PIC X(80) VALUE "MYFILE2".
       01  WSFS              PIC X(2).
       PROCEDURE DIVISION.
      *
           OPEN OUTPUT FILE0
           DISPLAY "STATUS OPENO 0 " WSFS
           OPEN OUTPUT FILE1
           DISPLAY "STATUS OPENO 1 " WSFS
           OPEN OUTPUT FILE2
           DISPLAY "STATUS OPENO 2 " WSFS
      *
           STOP RUN.