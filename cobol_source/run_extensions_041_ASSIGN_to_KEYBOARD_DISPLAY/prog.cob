IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN  KEYBOARD
                        ORGANIZATION IS LINE SEQUENTIAL.
       SELECT TEST-OUT  ASSIGN  DISPLAY
                        ORGANIZATION IS LINE SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(80).
       FD TEST-OUT.
       01 TEST-REC-OUT  PIC X(80).
       PROCEDURE        DIVISION.
       A00.
           OPEN INPUT  TEST-FILE.
           OPEN OUTPUT TEST-OUT.
       A01.
           READ TEST-FILE AT END
                GO TO Z99
           END-READ.
           WRITE TEST-REC-OUT FROM TEST-REC
           END-WRITE.
           GO TO A01.
       Z99.
           CLOSE TEST-FILE.
           CLOSE TEST-OUT.
           STOP RUN.