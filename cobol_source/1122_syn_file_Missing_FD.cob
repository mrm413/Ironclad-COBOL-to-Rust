IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK.
       SELECT file2 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       FD file2.
       01 file2-rec PIC X.
       PROCEDURE DIVISION.
           OPEN input file1
           STOP RUN.