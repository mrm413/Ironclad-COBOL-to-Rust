IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN TO 'FILE-TEST'
                        ORGANIZATION IS SEQUENTIAL.
       SELECT TEST-FIL2 ASSIGN TO 'FILE-TEST-2'
                        ORGANIZATION IS SEQUENTIAL.
       SELECT TEST-FIL3 ASSIGN TO 'FILE-TEST-3'
                        ORGANIZATION IS SEQUENTIAL.
       SELECT TEST-FIL4 ASSIGN TO 'FILE-TEST-4'
                        ORGANIZATION IS SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE
           RECORD IS VARYING IN SIZE
              FROM 12 TO 125 CHARACTERS
                 DEPENDING ON RECORDSIZE.
       01  TEST-REC.
           05 FILLER    PIC X(40).
       FD TEST-FIL2
           RECORD IS VARYING IN SIZE
              FROM 20 TO 250 CHARACTERS
                 DEPENDING ON TEST-FILE.
       01  TEST-REC2.
           05 FILLER       PIC X(129).
           05 RECORDSIZE3  PIC 9(04).
           05 RECORDSIZE4  PIC X(04).
       FD TEST-FIL3
           RECORD IS VARYING IN SIZE
              FROM 40 TO 50  CHARACTERS
                 DEPENDING ON RECORDSIZE3.
       01  TEST-REC3.
           05 FILLER    PIC X(50).
       FD TEST-FIL4
           RECORD IS VARYING IN SIZE
              FROM 1 TO 2  CHARACTERS
                 DEPENDING ON RECORDSIZE4.
       01  TEST-REC4.
           05 FILLER    PIC X(2).
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           OPEN  INPUT TEST-FIL2.
           CLOSE TEST-FIL2.
           OPEN  INPUT TEST-FIL3.
           CLOSE TEST-FIL3.
           OPEN  INPUT TEST-FIL4.
           CLOSE TEST-FIL4.
           STOP RUN.