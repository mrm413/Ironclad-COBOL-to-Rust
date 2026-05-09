IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ORGANIZATION SEQUENTIAL
                    ASSIGN "./file1".
       SELECT file2 ORGANIZATION SEQUENTIAL
                    ASSIGN "./file2".
       SELECT file3 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       FD file1 RECORD VARYING FROM 3 TO 12 DEPENDING rsz.
       1  file1-rec pic x(12).
       FD file2 RECORD VARYING FROM 3 TO 12 DEPENDING rsz.
       1  file2-rec pic x(12).
       SD file3 RECORD VARYING FROM 3 TO 12 DEPENDING rsz.
       1  file3-rec.
          2  file3-key1 pic x.
          2  file3-key2 pic 9.
          2  filler pic x(10).
       WORKING-STORAGE SECTION.
       77 rsz pic 99.
       1  1-data.
          2  filler pic x(14) VALUE "03A4X".
          2  filler pic x(14) VALUE "04A3XX".
          2  filler pic x(14) VALUE "05A2XXX".
          2  filler pic x(14) VALUE "06A1XXXX".
          2  filler pic x(14) VALUE "07A0XXXXX".
          2  filler pic x(14) VALUE "08B2XXXXXX".
          2  filler pic x(14) VALUE "09B1XXXXXXX".
          2  filler pic x(14) VALUE "10C2XXXXXXXX".
          2  filler pic x(14) VALUE "11C1XXXXXXXXX".
          2  filler pic x(14) VALUE "12Z9XXXXXXXXXX".
      *
       1  filler redefines 1-data.
          2  filler occurs 10 times indexed by ix-1.
           3 1-rsz pic 99.
           3 1-rec pic x(12).

       PROCEDURE DIVISION.
          OPEN OUTPUT file1.
          PERFORM VARYING ix-1 FROM 1 BY 2 UNTIL ix-1 > 10
             MOVE 1-rsz(ix-1) TO rsz
             MOVE 1-rec(ix-1) TO file1-rec
             WRITE file1-rec
          END-PERFORM.
          PERFORM VARYING ix-1 FROM 2 BY 2 UNTIL ix-1 > 10
             MOVE 1-rsz(ix-1) TO rsz
             MOVE 1-rec(ix-1) TO file1-rec
             WRITE file1-rec
          END-PERFORM.
          CLOSE file1.
          SORT file3 ON ASCENDING file3-key1
                        DESCENDING file3-key2
             USING file1
             GIVING file2.
          OPEN INPUT file2.
          PERFORM VARYING ix-1 FROM 1 BY 1 UNTIL ix-1 > 10
             READ file2
      *>> fileio-sort currently returns constant length records
             MOVE 1-rsz(ix-1) TO rsz
      *>> END-OF-DETOUR
             IF (1-rsz(ix-1) <> rsz)
                DISPLAY "FAILED Test " ix-1 ": "
                        1-rsz(ix-1) " <> " rsz
             END-IF
             IF (1-rec(ix-1) <> file2-rec)
                DISPLAY "FAILED Test " ix-1 ": " 
                        1-rec(ix-1) " <> " file2-rec
             END-IF
          END-PERFORM.
          CLOSE file2.
          STOP RUN.