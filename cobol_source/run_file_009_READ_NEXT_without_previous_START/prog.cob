IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS  INDEXED
                        ACCESS MODE  IS  SEQUENTIAL
                        RECORD KEY   IS  TEST-KEY.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC.
          05 TEST-KEY      PIC X(10).
          05 TEST-DATA     PIC X.
       PROCEDURE        DIVISION.
           OPEN  OUTPUT TEST-FILE
           MOVE  '1'    TO TEST-KEY
           MOVE  'A'    TO TEST-DATA
           WRITE TEST-REC
           MOVE  '3'    TO TEST-KEY
           MOVE  'B'    TO TEST-DATA
           WRITE TEST-REC
           CLOSE TEST-FILE
           OPEN  INPUT  TEST-FILE
           READ  TEST-FILE NEXT
                 AT END
                   DISPLAY "AT END FOR REC1"
                   END-DISPLAY
                   CLOSE TEST-FILE
                   STOP RUN
                 NOT AT END
                   CONTINUE
           END-READ
           IF TEST-DATA NOT = 'A'
              DISPLAY "WRONG REC1: '" TEST-REC "'"
              END-DISPLAY
           END-IF
           READ  TEST-FILE NEXT
                 AT END
                   DISPLAY "AT END FOR REC2"
                   END-DISPLAY
                   CLOSE TEST-FILE
                   STOP RUN
                 NOT AT END
                   CONTINUE
           END-READ.
           IF TEST-DATA NOT = 'B'
              DISPLAY "WRONG REC2: '" TEST-REC "'"
              END-DISPLAY
           END-IF
           READ  TEST-FILE NEXT
                 AT END
                   CONTINUE
                 NOT AT END
                   DISPLAY "NOT AT END AFTER REC2"
                   END-DISPLAY
           END-READ
           IF TEST-DATA NOT = 'B'
              DISPLAY "DATE CHANGED ON EOF: '" TEST-REC "'"
              END-DISPLAY
           END-IF
           CLOSE TEST-FILE
           STOP RUN.