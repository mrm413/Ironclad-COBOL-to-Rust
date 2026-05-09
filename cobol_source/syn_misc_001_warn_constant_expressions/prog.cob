IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           IF 3 = 1
           AND 2 OR 3
              DISPLAY "OK"
              END-DISPLAY
           END-IF.
           IF 3 = 1 OR
              2 AND 3
              DISPLAY "NO"
              END-DISPLAY
           END-IF
           IF "a" = "b"
              DISPLAY "NO"
              END-DISPLAY
           END-IF.
           IF "c" = "c    "
              DISPLAY "NO"
              END-DISPLAY
           END-IF.
           STOP RUN.