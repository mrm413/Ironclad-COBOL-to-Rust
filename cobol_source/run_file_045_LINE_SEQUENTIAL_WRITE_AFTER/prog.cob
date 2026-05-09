IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS LINE SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       PROCEDURE        DIVISION.
           OPEN OUTPUT TEST-FILE.
           MOVE "a"    TO TEST-REC.
           WRITE TEST-REC
           END-WRITE.
           MOVE "ab"   TO TEST-REC.
           WRITE TEST-REC AFTER 1 LINES
           END-WRITE.
           MOVE "abc"  TO TEST-REC.
           WRITE TEST-REC BEFORE 2 LINES
           END-WRITE.
           MOVE "abcd" TO TEST-REC.
           WRITE TEST-REC
           END-WRITE.
           CLOSE TEST-FILE.
           STOP RUN.