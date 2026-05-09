IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS  INDEXED
                        ACCESS MODE  IS  SEQUENTIAL
                        RECORD KEY   IS  TEST-KEY.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-KEY      PIC X(10).
       PROCEDURE        DIVISION.
           OPEN  OUTPUT TEST-FILE.
           CLOSE TEST-FILE.
           OPEN  INPUT  TEST-FILE.
           READ  TEST-FILE
                 AT END
                   CONTINUE
                 NOT AT END
                   DISPLAY "NOT OK"
                   END-DISPLAY
           END-READ.
           CLOSE TEST-FILE.
           STOP RUN.