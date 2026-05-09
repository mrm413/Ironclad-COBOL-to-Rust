IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN "./TEST-FILE".
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE.
       01  TEST-REC     PIC X(10).
       WORKING-STORAGE  SECTION.
       01  X            PIC X(10).
       PROCEDURE        DIVISION.
           OPEN  OUTPUT TEST-FILE.
           CLOSE TEST-FILE.
           OPEN  INPUT  TEST-FILE.
           READ  TEST-FILE INTO X
               AT END MOVE ALL ZERO TO X
           END-READ.
           CLOSE TEST-FILE.
           IF X NOT = "0000000000"
              DISPLAY "Expected zeros - Got " X
              END-DISPLAY
           END-IF.
           STOP RUN.