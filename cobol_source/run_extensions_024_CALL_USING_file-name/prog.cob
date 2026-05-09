IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN FILENAME.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       WORKING-STORAGE  SECTION.
       01 FILENAME      PIC X(8).
       PROCEDURE        DIVISION.
           INITIALIZE FILENAME.
           CALL "setfilename" USING TEST-FILE "TESTFILE"
           END-CALL.
           OPEN OUTPUT TEST-FILE.
           CLOSE TEST-FILE.
           STOP RUN.