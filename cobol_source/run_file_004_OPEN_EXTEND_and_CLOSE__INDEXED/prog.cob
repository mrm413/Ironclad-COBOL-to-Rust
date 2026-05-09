IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  OPTIONAL      FILE-OPT
                   ASSIGN        TO "testfile"
                   ORGANIZATION  IS INDEXED
                   RECORD KEY    IS FOREC
                   FILE STATUS   IS WSFS.
           SELECT  FILE0         ASSIGN TO "testfile"
                   ORGANIZATION  IS INDEXED
                   RECORD KEY    IS F0REC
                   FILE STATUS   IS WSFS.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE0.
       01  F0REC             PIC X(80).
       FD  FILE-OPT.
       01  FOREC             PIC X(80).
       WORKING-STORAGE SECTION.
       01  WSFS              PIC X(2).
       PROCEDURE DIVISION.
      *
           OPEN EXTEND FILE-OPT
           IF WSFS NOT = "05"
              DISPLAY "STATUS EXTEND, missing optional file:" WSFS.
           MOVE ALL "A" TO FOREC
           WRITE FOREC
           IF WSFS NOT = "00"
              DISPLAY "STATUS WRITE A:" WSFS.
           CLOSE FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS CLOSE:" WSFS.
           OPEN EXTEND FILE0
           IF WSFS NOT = "00"
              DISPLAY "STATUS EXTEND, empty file:" WSFS.
           MOVE ALL "B" TO F0REC
           WRITE F0REC
           IF WSFS NOT = "00"
              DISPLAY "STATUS WRITE B:" WSFS.
           CLOSE FILE0
      *
           OPEN INPUT FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS INPUT:" WSFS.
           MOVE ALL "A" TO FOREC
           READ FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS READ A:" WSFS.
           MOVE ALL "B" TO FOREC
           READ FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS READ B:" WSFS.
           CLOSE FILE-OPT
      *
           STOP RUN.