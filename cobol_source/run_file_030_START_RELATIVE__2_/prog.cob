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
           88  V-ZERO   VALUE "00".
       PROCEDURE        DIVISION.
           OPEN  I-O   TEST-FILE.
           IF NOT V-OK
              DISPLAY "OPEN " TESTSTAT
              END-DISPLAY
              GOBACK
           END-IF.
           MOVE 3 TO TESTKEY.
           MOVE "0003" TO TEST-REC.
           WRITE TEST-REC INVALID KEY
                 DISPLAY "WRITE " TESTSTAT
                 END-DISPLAY
           END-WRITE.
           MOVE 2 TO TESTKEY.
           MOVE "0002" TO TEST-REC.
           WRITE TEST-REC INVALID KEY
                 DISPLAY "WRITE " TESTSTAT
                 END-DISPLAY
           END-WRITE.
           MOVE 99 TO TESTKEY.
           START TEST-FILE KEY < TESTKEY
           END-START.
           IF NOT V-ZERO
              DISPLAY "START " TESTSTAT
              END-DISPLAY
           END-IF.
           IF TESTKEY NOT = 99
              DISPLAY "TESTKEY " TESTKEY
              END-DISPLAY
           END-IF.
           MOVE  SPACE TO TEST-REC.
           READ  TEST-FILE NEXT
           END-READ.
           IF NOT V-ZERO
              DISPLAY "READ " TESTSTAT
              END-DISPLAY
           END-IF.
           IF TEST-REC NOT = "0003"
              DISPLAY "READ RECORD " TEST-REC
              END-DISPLAY
           END-IF.
           CLOSE TEST-FILE.
       END PROGRAM prog.