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
           OPEN  OUTPUT TEST-FILE NO REWIND
           WRITE TEST-REC FROM "tEsT"
           END-WRITE
           WRITE TEST-REC FROM "TeSt"
           END-WRITE
           CLOSE TEST-FILE WITH NO REWIND
           OPEN  INPUT TEST-FILE WITH LOCK WITH NO REWIND
           READ TEST-FILE NEXT  *> should get EOF
           END-READ
           CLOSE TEST-FILE
           STOP RUN.