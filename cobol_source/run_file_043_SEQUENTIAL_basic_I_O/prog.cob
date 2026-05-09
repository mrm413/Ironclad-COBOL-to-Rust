IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK ORGANIZATION SEQUENTIAL.
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
           OPEN I-O file1.
           READ file1.
           IF file1-rec <> "A"
              display "FIRST READ FAILED"
           ELSE
              MOVE "X" TO file1-rec
              REWRITE file1-rec.
           CLOSE file1.
           IF file1-rec NOT = "X"
              STOP RUN.
           OPEN INPUT file1.
           READ file1.
           IF file1-rec <> "X"
              display "SECOND READ FAILED".
           CLOSE file1.
           STOP RUN.