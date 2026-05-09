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
           OPEN INPUT TEST-FILE
           PERFORM UNTIL EXIT
              READ TEST-FILE
                  AT END EXIT PERFORM
              END-READ
              DISPLAY "(" TEST-REC ")"
              END-DISPLAY
           END-PERFORM.
           CLOSE TEST-FILE.
           STOP RUN.