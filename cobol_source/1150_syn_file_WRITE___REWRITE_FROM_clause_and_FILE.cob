IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.
       ENVIRONMENT    DIVISION.
       INPUT-OUTPUT   SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN TO 'FILE-TEST'
                        ORGANIZATION IS INDEXED
                        ACCESS MODE  IS DYNAMIC
                        RECORD KEY   IS TEST-P1.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01  TEST-REC.
           05 TEST-P1   PIC X(4).
           05 TEST-P2   PIC S9(4) COMP.
       WORKING-STORAGE  SECTION.
       01  SOME-REC     PIC X(04).
           88  SOME-VAL VALUE 'ABCD'.
       PROCEDURE        DIVISION.
           OPEN  I-O TEST-FILE.
           WRITE   SOME-VAL.
           WRITE   SOME-REC.
           WRITE   TEST-REC.
           WRITE   TEST-REC FROM SOME-REC.
           WRITE   TEST-FILE.
           WRITE   FILE TEST-REC.
           WRITE   FILE TEST-FILE.
           WRITE   FILE TEST-FILE FROM TEST-REC.
           WRITE   FILE TEST-FILE FROM SOME-REC.
           REWRITE SOME-VAL.
           REWRITE SOME-REC.
           REWRITE TEST-REC.
           REWRITE TEST-REC FROM SOME-REC.
           REWRITE TEST-FILE.
           REWRITE FILE TEST-REC.
           REWRITE FILE TEST-FILE.
           REWRITE FILE TEST-FILE FROM TEST-REC.
           REWRITE FILE TEST-FILE FROM SOME-REC.
           CLOSE TEST-FILE.
           STOP RUN.