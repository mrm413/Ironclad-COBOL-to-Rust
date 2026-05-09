IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN TO "./file1X"
                    ORGANIZATION INDEXED
                    ACCESS DYNAMIC RECORD KEY file1-key.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec.
          2  file1-key pic 999.
          2  file1-data pic 999.
       PROCEDURE DIVISION.
          OPEN OUTPUT file1.
          CLOSE file1.
          OPEN I-O file1.
          MOVE 10 TO file1-key file1-data.
          WRITE file1-rec.
          MOVE 11 TO file1-key file1-data.
          WRITE file1-rec.
          MOVE 12 TO file1-key file1-data.
          WRITE file1-rec.
          MOVE 13 TO file1-key file1-data.
          WRITE file1-rec.
      *
          MOVE 0 TO file1-key.
          START file1 KEY > file1-key.
          READ file1 NEXT.
          IF (file1-data <> 10)
             DISPLAY "FAILED: START key > 0".
      *
          MOVE 99 TO file1-key.
          START file1 KEY < file1-key.
          READ file1 NEXT.
          IF (file1-data <> 13)
             DISPLAY "FAILED: START key < 99".
      *
          MOVE 999 TO file1-key.
          START file1 FIRST.
          READ file1 NEXT.
          IF (file1-data <> 10)
             DISPLAY "FAILED: START key FIRST".
      *
          MOVE 0 TO file1-key.
          START file1 LAST.
          READ file1 NEXT.
          IF (file1-data <> 13)
             DISPLAY "FAILED: START key LAST".
      *
          MOVE 0 TO file1-key.
          START file1 KEY >= file1-key.
          READ file1 NEXT.
          IF (file1-data <> 10)
             DISPLAY "FAILED: START key >= 0".
      *
          MOVE 99 TO file1-key.
          START file1 KEY <= file1-key.
          READ file1 NEXT.
          IF (file1-data <> 13)
             DISPLAY "FAILED: START key <= 99".

          CLOSE file1.
          STOP RUN.