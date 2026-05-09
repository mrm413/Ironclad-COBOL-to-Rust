IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN TO "./fileX"
                    ORGANIZATION INDEXED
                    ACCESS RANDOM
                    RECORD KEY file1-key1
                    ALTERNATE RECORD KEY file1-key2
                    ALTERNATE RECORD KEY file1-key3.
       SELECT file2 ASSIGN TO "./fileX"
                    ORGANIZATION INDEXED
                    ACCESS RANDOM
                    RECORD KEY file2-key1
                    ALTERNATE RECORD KEY file2-key2.
       SELECT file3 ASSIGN TO "./fileX"
                    ORGANIZATION INDEXED
                    ACCESS RANDOM
                    RECORD KEY file3-key1.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec.
          2  file1-key1 pic 999.
          2  file1-key2 pic 999.
          2  file1-key3 pic 999.
          2  file1-data pic 999.
       FD file2.
       1  file2-rec.
          2  file2-key1 pic 999.
          2  file2-key2 pic 999.
          2  file2-key3 pic 999.
          2  file2-data pic 999.
       FD file3.
       1  file3-rec.
          2  file3-key1 pic 999.
          2  file3-key2 pic 999.
          2  file3-key3 pic 999.
          2  file3-data pic 999.
       WORKING-STORAGE SECTION.
       77 ix pic 9(6).
       PROCEDURE DIVISION.
          OPEN OUTPUT file1.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             MOVE ix TO file1-key1 file1-data
             ADD 100 TO ix GIVING file1-key2
             ADD 200 TO ix GIVING file1-key3
             WRITE file1-rec
          END-PERFORM.
          CLOSE file1.
      *
          OPEN INPUT file1.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             MOVE ix TO file1-key1
             READ file1 KEY file1-key1
             IF (file1-data <> ix)
                DISPLAY "FAILED 1-1"
             END-IF
          END-PERFORM.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             ADD 100 TO ix GIVING file1-key2
             READ file1 KEY file1-key2
             IF (file1-data <> ix)
                DISPLAY "FAILED 1-2"
             END-IF
          END-PERFORM.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             ADD 200 TO ix GIVING file1-key3
             READ file1 KEY file1-key3
             IF (file1-data <> ix)
                DISPLAY "FAILED 1-3"
             END-IF
          END-PERFORM.
          CLOSE file1.
      *
          OPEN INPUT file2.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             MOVE ix TO file2-key1
             READ file2 KEY file2-key1
             IF (file2-data <> ix)
                DISPLAY "FAILED 2-1"
             END-IF
          END-PERFORM.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             ADD 100 TO ix GIVING file2-key2
             READ file2 KEY file2-key2
             IF (file2-data <> ix)
                DISPLAY "FAILED 2-2"
             END-IF
          END-PERFORM.
          CLOSE file2.
      *
          OPEN INPUT file3.
          PERFORM VARYING ix FROM 1 BY 1
             UNTIL ix > 10
             MOVE ix TO file3-key1
             READ file3 KEY file3-key1
             IF (file3-data <> ix)
                DISPLAY "FAILED 3-1"
             END-IF
          END-PERFORM.
          CLOSE file3.
      *
      *   Insert rec via file with only 1 index declared
          OPEN I-O file3.
          MOVE 20 TO ix.
          MOVE ix TO file3-key1 file3-data
          ADD 100 TO ix GIVING file3-key2
          ADD 200 TO ix GIVING file3-key3
          WRITE file3-rec
          CLOSE file3
      *
      *   Check new rec is visible in other files
          OPEN INPUT file1.
          MOVE 10 TO file1-key1.
          READ file1 KEY file1-key1.
          IF (file1-data <> 10)
             DISPLAY "FAILED 1-4".
          MOVE SPACES TO file1-rec.
          MOVE 110 TO file1-key2.
          READ file1 KEY file1-key2.
          IF (file1-data <> 10)
             DISPLAY "FAILED 1-5".
          MOVE SPACES TO file1-rec.
          MOVE 210 TO file1-key3.
          READ file1 KEY file1-key3.
          IF (file1-data <> 10)
             DISPLAY "FAILED 1-6".
          CLOSE file1.
      *
          OPEN INPUT file2.
          MOVE 10 TO file2-key1.
          READ file2 KEY file2-key1.
          IF (file2-data <> 10)
             DISPLAY "FAILED 2-3".
          MOVE SPACES TO file2-rec.
          MOVE 110 TO file2-key2.
          READ file2 KEY file2-key2.
          IF (file2-data <> 10)
             DISPLAY "FAILED 2-4".
          CLOSE file2.
          STOP RUN.