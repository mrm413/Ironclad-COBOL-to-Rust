IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT file2 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       FD  file1.
       01  file1-rec PIC X.
       FD  file2.
       01  file2-rec PIC X.
       PROCEDURE DIVISION.
           STOP RUN.