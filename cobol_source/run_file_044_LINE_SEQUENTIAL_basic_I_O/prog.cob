IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK ORGANIZATION LINE SEQUENTIAL.
       SELECT file2 ASSIGN DISK ORGANIZATION LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec pic x.
       FD file2.
       1  file2-rec pic xx.
       PROCEDURE DIVISION.
           DELETE FILE file1, file2
           OPEN OUTPUT file1, file2
           MOVE "A" TO file1-rec, file2-rec
           WRITE file1-rec
           WRITE file2-rec
           MOVE " " TO file1-rec, file2-rec
           WRITE file1-rec
           WRITE file2-rec
           WRITE file1-rec FROM "A"
           WRITE file2-rec FROM "AA"
           WRITE file1-rec FROM " "
           WRITE file2-rec FROM " A"
           CLOSE file1, file2
           OPEN INPUT file1, file2
           READ file1
           IF file1-rec NOT = "A"
              display "FAILED 1 file1 - '" file1-rec "'".
           READ file2
           IF file2-rec NOT = "A"
              display "FAILED 1 file2 - '" file2-rec "'".
           READ file1
           IF file1-rec NOT = SPACE
              display "FAILED 2 file1 - '" file1-rec "'".
           READ file2
           IF file2-rec NOT = SPACES
              display "FAILED 2 file2 - '" file2-rec "'".
           READ file1
           IF file1-rec NOT = "A"
              display "FAILED 3 file1 - '" file1-rec "'".
           READ file2
           IF file2-rec NOT = "AA"
              display "FAILED 3 file2 - '" file2-rec "'".
           READ file1
           IF file1-rec NOT = SPACE
              display "FAILED 4 file1 - '" file1-rec "'".
           READ file2
           IF file2-rec NOT = " A"
              display "FAILED 4 file2 - '" file2-rec "'".
           CLOSE file1, file2.
           STOP RUN.