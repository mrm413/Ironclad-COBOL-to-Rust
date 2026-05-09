IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN  KEYBOARD
                        ORGANIZATION IS LINE SEQUENTIAL.
       SELECT TEST-OUT  ASSIGN  DISPLAY
                        ORGANIZATION IS LINE SEQUENTIAL.
       SELECT SORT-FILE.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(80).
       FD TEST-OUT.
       01 TEST-REC-OUT  PIC X(80).
       SD SORT-FILE.
       01 SORT-REC      PIC X(80).
       PROCEDURE        DIVISION.
       A00.
           SORT SORT-FILE
                ON ASCENDING SORT-REC
                USING        TEST-FILE
                GIVING       TEST-OUT.
           STOP RUN.