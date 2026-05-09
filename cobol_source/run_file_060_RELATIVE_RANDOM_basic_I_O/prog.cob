IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK
          ORGANIZATION RELATIVE
          ACCESS RANDOM RELATIVE KEY file1-key.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec pic x.
       WORKING-STORAGE SECTION.
       77  file1-key pic 99.
       PROCEDURE DIVISION.
           DELETE FILE file1.
           OPEN OUTPUT file1.
           MOVE 1 to file1-key.
           MOVE "A" TO file1-rec.
           WRITE file1-rec.
           MOVE 2 to file1-key.
           MOVE "B" TO file1-rec.
           WRITE file1-rec.
           MOVE 3 to file1-key.
           MOVE "C" TO file1-rec.
           WRITE file1-rec.
           CLOSE file1.
           OPEN INPUT file1.
           MOVE 2 to file1-key.
           READ file1.
           IF (file1-rec <> "B")
              display "FAILED".
           MOVE 1 to file1-key.
           READ file1.
           IF (file1-rec <> "A")
              display "FAILED".
           CLOSE file1.
           STOP RUN.