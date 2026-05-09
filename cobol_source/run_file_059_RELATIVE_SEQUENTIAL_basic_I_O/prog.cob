IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK ORGANIZATION RELATIVE.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec pic x.
       PROCEDURE DIVISION.
           DELETE FILE file1.
           OPEN OUTPUT file1.
           MOVE "A" TO file1-rec.
           WRITE file1-rec.
           CLOSE file1.
           OPEN INPUT file1.
           READ file1.
           IF (file1-rec <> "A")
              display "FAILED".
           CLOSE file1.
           STOP RUN.