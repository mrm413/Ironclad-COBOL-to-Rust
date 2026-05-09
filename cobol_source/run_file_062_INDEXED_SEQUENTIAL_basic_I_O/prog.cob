IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT fileX ASSIGN DISK ORGANIZATION INDEXED
           RECORD KEY fileX-key.
       DATA DIVISION.
       FILE SECTION.
       FD fileX.
       1  fileX-rec.
          2 fileX-key pic x(6).
          2 fileX-data pic x(10).
       PROCEDURE DIVISION.
           OPEN OUTPUT fileX.
           MOVE ALL "A" TO fileX-rec.
           WRITE fileX-rec.
           CLOSE fileX.
           OPEN INPUT fileX.
           READ fileX.
           IF (fileX-rec <> ALL "A")
              display "FAILED".
           CLOSE fileX.
           STOP RUN.