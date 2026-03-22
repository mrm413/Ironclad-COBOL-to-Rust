IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT file1 ASSIGN TO 'FILE-TEST'
                        ORGANIZATION IS INDEXED
                        ACCESS MODE  IS DYNAMIC
                        RECORD KEY   IS file1-key
                        STATUS       IS STATUS-1.
           SELECT file2 ASSIGN TO 'FILE-TEST'
                        ORGANIZATION IS INDEXED
                        ACCESS MODE  IS DYNAMIC
                        RECORD KEY   IS file2-key
                        STATUS       IS STATUS-1, STATUS-2.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE1.
       01  FILE1-REC.
           05 FILE1-KEY PIC X.
       FD  FILE2.
       01  FILE2-REC.
           05 FILE2-KEY PIC 9.
           05 FILE2-DAT PIC X.
       WORKING-STORAGE SECTION.
       77  STATUS-1 PIC X(02).
       77  STATUS-2 PIC X(06).
       PROCEDURE DIVISION.
            STOP RUN.