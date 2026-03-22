IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT file1 ASSIGN TO 'FILE-TEST'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD KEY    IS file1-key PASSWORD IS PASS1
                        STATUS        IS FSTAT.
           SELECT file2 ASSIGN TO 'FILE-TEST-EXT'
                        ORGANIZATION  IS INDEXED
                        ACCESS MODE   IS DYNAMIC
                        RECORD KEY    IS file2-key PASSWORD IS PASS2
                        ALTERNATE RECORD KEY IS NOTHEREKEY
                           SOURCE     IS file2-dat file2-key
                           PASSWORD   IS PASS-EXT
                        STATUS        IS FSTAT.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE1.
       01  FILE1-REC.
           05 FILE1-KEY PIC X.
       FD  FILE2  EXTERNAL.
       01  FILE2-REC.
           05 FILE2-KEY PIC 9.
           05 FILE2-DAT PIC X.
       WORKING-STORAGE SECTION.
       77  FSTAT       PIC X(02).
      *> note: IBM specifies PASSWORDs are cut at / space filled to 8 bytes
       77  PASS1       PIC X(08).
       77  PASS2       PIC X(10).
       77  PASS-EXT    PIC X(04) EXTERNAL.
       PROCEDURE DIVISION.
           STOP RUN.