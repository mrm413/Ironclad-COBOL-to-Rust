IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL INFILE  ASSIGN TO
                "missing.txt"
                ORGANIZATION IS RELATIVE
                ACCESS IS SEQUENTIAL
                FILE STATUS IS WSFS.
           SELECT OPTIONAL INFILES ASSIGN TO
                "missings.txt"
                ORGANIZATION IS SEQUENTIAL
                ACCESS IS SEQUENTIAL
                FILE STATUS IS WSFS.
       DATA DIVISION.
       FILE SECTION.
       FD  INFILE.
       01  INREC             PIC X(80).
       FD  INFILES.
       01  INRECS            PIC X(80).
       WORKING-STORAGE SECTION.
       01  WSFS           PIC X(2).
           88  RECORDFOUND VALUE "00".
       01  WSINREC         PIC X(80).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
      *    Open missing file
           OPEN INPUT INFILE
           DISPLAY "R: OPEN INPUT on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '05'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.
           OPEN INPUT INFILES
           DISPLAY "S: OPEN INPUT on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '05'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.
      *    First read, raise a FS 10 (AT END) which is expected
           READ INFILE INTO WSINREC
           DISPLAY "R: 1st READ on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '10'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.
           READ INFILES INTO WSINREC
           DISPLAY "S: 1st READ on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '10'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.

      *    Second read, should raise a FS 46 (READ AFTER AT END).
           READ INFILE INTO WSINREC
           DISPLAY "R: 2nd READ on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '46'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.
           READ INFILES INTO WSINREC
           DISPLAY "S: 2nd READ on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '46'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.
           READ INFILE
           DISPLAY "R: 3rd READ on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '46'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.
           READ INFILES
           DISPLAY "S: 3rd READ on missing optional file = " WSFS " "
                    NO ADVANCING
           IF WSFS = '46'
              DISPLAY "OK"
           ELSE
              DISPLAY "Bad"
           END-IF.

           CLOSE INFILE
           CLOSE INFILES
           STOP RUN.