IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL INFILE ASSIGN TO "MYFILE"
                ORGANIZATION IS RELATIVE
                ACCESS IS SEQUENTIAL
                FILE STATUS IS WSFS.
       DATA DIVISION.
       FILE SECTION.
       FD  INFILE.
       01  INREC             PIC X(80).
       WORKING-STORAGE SECTION.
       01  WSFS              PIC X(2).
       PROCEDURE DIVISION.
      *
      *    open missing file
           OPEN INPUT INFILE
           DISPLAY "STATUS OPENI " WSFS
           CLOSE INFILE
      *
      *    create missing file
           OPEN OUTPUT INFILE
           DISPLAY "STATUS OPENO " WSFS
           CLOSE INFILE
      *
           STOP RUN.