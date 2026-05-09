IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
           *> Labels should be removed from EXTERNAL name.
           SELECT TEST-FILE   ASSIGN DA-S-FILENAME.
           *> EXTERNAL name allowed to duplicate FD name.
           SELECT TESTFILE2 ASSIGN TESTFILE2.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       FD TESTFILE2.
       01 TESTREC2      PIC X(4).
       PROCEDURE        DIVISION.
           OPEN OUTPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.