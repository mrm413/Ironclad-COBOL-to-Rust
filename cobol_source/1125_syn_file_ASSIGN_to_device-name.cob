IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       TO DISK 'TFILE'
                        ORGANIZATION IS SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.