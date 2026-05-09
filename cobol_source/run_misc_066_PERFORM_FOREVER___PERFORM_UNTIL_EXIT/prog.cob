IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  INDVAL       PIC 9(4).
       PROCEDURE        DIVISION.
       A01.
           MOVE 0 TO INDVAL
           PERFORM UNTIL EXIT
            ADD 1 TO INDVAL
            IF INDVAL > 2
               EXIT PERFORM
            END-IF
           END-PERFORM
           IF INDVAL NOT = 3
              DISPLAY "1: " INDVAL
              END-DISPLAY
           END-IF
           PERFORM FOREVER
            ADD 1 TO INDVAL
            IF INDVAL > 4
               EXIT PERFORM
            END-IF
           END-PERFORM
           IF INDVAL NOT = 5
              DISPLAY "2: " INDVAL
              END-DISPLAY
           END-IF
           STOP RUN.