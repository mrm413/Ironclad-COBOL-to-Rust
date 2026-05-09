IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  f-path     PIC X(80) VALUE "fooasg.txt".
       01  x-path     PIC X(80) VALUE "foxasg.txt".
       01  y-path     PIC X(80) VALUE "foyasg.txt".
       01  REC1       PIC 9(4) VALUE 1.
       01  REC2       PIC 9(4) VALUE 2.
       01  CUST-STAT  PIC X(2) VALUE "XX".

       PROCEDURE DIVISION.
           CALL "TSTOPN"  USING OMITTED.
           CALL "TSTOPN"  USING y-path.
           CALL "TSTOPEN" USING f-path  REC1 CUST-STAT.
           CALL "TSTOPEN" USING x-path  REC1 CUST-STAT.
           CALL "TSTOPEN" USING OMITTED REC1 CUST-STAT.
           CALL "TSTOPEN" USING f-path  REC2 CUST-STAT.
           CALL "TSTOPEN" USING x-path  REC2 CUST-STAT.
           STOP RUN.
           END PROGRAM prog.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TSTOPEN.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN s-path
           ORGANIZATION RELATIVE
           ACCESS IS RANDOM
           RELATIVE KEY IS REC-NUM
           FILE STATUS IS CUST-STAT.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-line PIC X(79).

       WORKING-STORAGE SECTION.
       01  z-path   PIC X(80) VALUE "foozzz.txt".

       LINKAGE SECTION.
       01  s-path     PIC X(80).
       01  REC-NUM    PIC 9(4).
       01  CUST-STAT  PIC X(2).

       PROCEDURE DIVISION USING OPTIONAL s-path, REC-NUM, CUST-STAT.
           IF ADDRESS OF s-path = NULL
              SET ADDRESS OF s-path TO ADDRESS OF z-path
           END-IF.
           IF REC-NUM > 1
              OPEN I-O f
              DISPLAY "Extend file: " s-path(1:10)
                   " - " CUST-STAT " #" REC-NUM "."
           ELSE
              OPEN OUTPUT f
              DISPLAY "Output file: " s-path(1:10)
                   " - " CUST-STAT " #" REC-NUM "."
           END-IF.
           IF CUST-STAT NOT = "00"
               DISPLAY "Opened error: " CUST-STAT "."
               GOBACK
           END-IF.
           MOVE "Hello World" TO f-line.
           MOVE REC-NUM       TO f-line (20:4).
           WRITE f-line.
           IF CUST-STAT NOT = "00"
               DISPLAY "WRITE error: " CUST-STAT "."
           END-IF.
           CLOSE f.
           GOBACK.
       END PROGRAM TSTOPEN.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TSTOPN.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN s-path
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS IS IO-STS.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-line PIC X(80).

       WORKING-STORAGE SECTION.
       01  IO-STS   PIC X(2) VALUE "00".

       LINKAGE SECTION.
       01  s-path   PIC X(80).

       PROCEDURE DIVISION USING OPTIONAL s-path.
           OPEN OUTPUT f
           IF IO-STS NOT = "00"
               DISPLAY "Opened error: " IO-STS "."
               GOBACK
           END-IF.
           DISPLAY "Opened file: " s-path(1:10) ".".
           MOVE "Hello World" TO f-line.
           WRITE f-line.
           CLOSE f.
           GOBACK.
       END PROGRAM TSTOPN.