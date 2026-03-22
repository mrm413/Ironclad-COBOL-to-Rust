IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       PROCEDURE        DIVISION.
           OPEN  INPUT TEST-FILE
           READ TEST-FILE NEXT
           END-READ
           CLOSE TEST-FILE
           OPEN  INPUT TEST-FILE REVERSED
           READ TEST-FILE NEXT
           END-READ
           CLOSE TEST-FILE
           OPEN  INPUT TEST-FILE WITH LOCK REVERSED
           READ TEST-FILE NEXT
           END-READ
           CLOSE TEST-FILE
           STOP RUN.