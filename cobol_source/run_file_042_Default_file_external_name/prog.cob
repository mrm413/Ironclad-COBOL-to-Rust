IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       FD file1.
       1  file1-rec.
          2  file1-date pic x(8).
          2  file1-time pic x(8).
       WORKING-STORAGE SECTION.
       77 erc      BINARY-LONG.
       77 rec-size BINARY-LONG VALUE 16.
       PROCEDURE DIVISION.
           ACCEPT file1-date FROM DATE YYYYMMDD.
           ACCEPT file1-time FROM TIME.
           OPEN OUTPUT file1.
           WRITE file1-rec.
           CLOSE file1.
           CALL "fexists_signed" USING
                BY REFERENCE "./file1" file1-rec
                BY VALUE rec-size
                RETURNING erc.
           IF (erc <> 0)
              DISPLAY "FAILED file1".
           STOP RUN.