IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS LINE SEQUENTIAL
                        STATUS IS    TEST-STATUS.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       WORKING-STORAGE  SECTION.
       77 TEST-STATUS   PIC XX.
       PROCEDURE        DIVISION.
           OPEN INPUT TEST-FILE
           PERFORM UNTIL TEST-STATUS (1:1) NOT = '0'
              READ TEST-FILE
              END-READ
              DISPLAY "(" TEST-REC ") " TEST-STATUS
              END-DISPLAY
           END-PERFORM.
           CLOSE TEST-FILE.
           STOP RUN.