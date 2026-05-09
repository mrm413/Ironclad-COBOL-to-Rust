IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ORGANIZATION LINE SEQUENTIAL
                    ASSIGN "./file1".
       SELECT file2 ORGANIZATION LINE SEQUENTIAL
                    ASSIGN "./file2".
       SELECT file3 ORGANIZATION LINE SEQUENTIAL
                    ASSIGN "./file3".
       SELECT file4 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec pic x(12).
       FD file2.
       1  file2-rec pic x(12).
       FD file3.
       1  file3-rec pic x(12).
       SD file4.
       1  file4-rec.
          2  file4-key1 pic x.
          2  file4-key2 pic 9.
          2  filler pic x(10).
       PROCEDURE DIVISION.
          MERGE file4 ON ASCENDING file4-key1
                        DESCENDING file4-key2
             USING file1 file2
             GIVING file3.
          STOP RUN.