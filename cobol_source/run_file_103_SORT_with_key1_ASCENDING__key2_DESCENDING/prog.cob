IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ORGANIZATION LINE SEQUENTIAL
                    ASSIGN "./file1".
       SELECT file2 ORGANIZATION LINE SEQUENTIAL
                    ASSIGN "./file2".
       SELECT file3 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec pic xxx.
       FD file2.
       1  file2-rec pic xxx.
       SD file3.
       1  file3-rec.
          2  file3-key1 pic x.
          2  file3-key2 pic 9.
          2  file3-dot pic x.
       PROCEDURE DIVISION.
          SORT file3 ON ASCENDING file3-key1
                        DESCENDING file3-key2
             USING file1
             GIVING file2.
          STOP RUN.