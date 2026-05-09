IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS RELATIVE
                        ACCESS MODE  IS RANDOM
                        RELATIVE KEY IS TEST-KEY.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X.
       WORKING-STORAGE  SECTION.
       01 TEST-KEY      PIC 9.
       PROCEDURE        DIVISION.
      *
           OPEN OUTPUT TEST-FILE.
           MOVE 1 TO TEST-KEY.
           MOVE "A" TO TEST-REC.
           WRITE TEST-REC
           END-WRITE.
           MOVE 2 TO TEST-KEY.
           MOVE "B" TO TEST-REC.
           WRITE TEST-REC
           END-WRITE.
           CLOSE TEST-FILE.
      *
           OPEN I-O TEST-FILE.
           MOVE 1 TO TEST-KEY.
           READ TEST-FILE
           END-READ.
           MOVE 2 TO TEST-KEY.
           MOVE "C" TO TEST-REC.
           REWRITE TEST-REC
           END-REWRITE.
           CLOSE TEST-FILE.
      *
           OPEN INPUT TEST-FILE.
           MOVE 1 TO TEST-KEY.
           READ TEST-FILE
           END-READ.
           IF TEST-REC NOT = "A"
              DISPLAY "Expected 'A' - Got " TEST-REC
              END-DISPLAY
           END-IF.
           MOVE 2 TO TEST-KEY.
           READ TEST-FILE
           END-READ.
           IF TEST-REC NOT = "C"
              DISPLAY "Expected 'C' - Got " TEST-REC
              END-DISPLAY
           END-IF.
           CLOSE TEST-FILE.
           STOP RUN.