IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog3.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       TO PRINTER-1 FNAME OF F1
                        ORGANIZATION IS SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       WORKING-STORAGE  SECTION.
       01 F1.
          05 FNAME      PIC X(255) VALUE 'PFILEOF'.
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.