IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT OPTIONAL TEST-FILE
              ASSIGN      "TESTFILE"
              ACCESS       DYNAMIC
              ORGANIZATION RELATIVE
              STATUS       TESTSTAT
              RELATIVE KEY TESTKEY
       .
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE.
       01  TEST-REC     PIC X(4).
       WORKING-STORAGE  SECTION.
       01  TESTKEY      USAGE BINARY-LONG UNSIGNED.
       01  TESTSTAT     PIC XX.
           88  V-OK     VALUE "00" "05".
       PROCEDURE        DIVISION.
           DELETE FILE TEST-FILE.
           OPEN  I-O   TEST-FILE.
           IF NOT V-OK
              DISPLAY "OPEN " TESTSTAT
              END-DISPLAY
              GOBACK
           END-IF.
           MOVE 99 TO TESTKEY.
           START TEST-FILE KEY < TESTKEY
           END-START.
           IF TESTSTAT NOT = "23"
              DISPLAY "START " TESTSTAT
              END-DISPLAY
           END-IF.
           CLOSE TEST-FILE.
       END PROGRAM prog.