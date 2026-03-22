IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78 FENCE         VALUE x'ABBAAB'.
       01 FILLER.      
         05 FENCE-A     PIC XXX VALUE FENCE.
         05 RESULT      PIC 9(03) PACKED-DECIMAL.
         05 FENCE-B     PIC XXX VALUE FENCE.
       PROCEDURE        DIVISION.
       MAIN.
      * internal arithmetic to DISPLAY
           MOVE 1 TO RESULT
           COMPUTE RESULT = 15 + RESULT - 2 / RESULT
           IF RESULT NOT = 14
              DISPLAY "NOT 14: " RESULT.

      * internal arithmetic to DISPLAY, with sign drop
           MOVE 1 TO RESULT
           COMPUTE RESULT = 15 + RESULT - 20 / RESULT
           IF RESULT NOT = 4
              DISPLAY "NOT [-] 4: " RESULT.

      * internal arithmetic to DISPLAY with truncation of decimal-part
           MOVE 1 TO RESULT
           COMPUTE RESULT = 15 + RESULT / 2
           IF RESULT NOT = 15
              DISPLAY "NOT 15: " RESULT.

      * internal arithmetic to DISPLAY with truncation of integer-part
           MOVE 1 TO RESULT
           COMPUTE RESULT = 15 + RESULT - 2000 / RESULT
           IF RESULT NOT = 984
              DISPLAY "NOT [-1] 984: " RESULT.

      * internal arithmetic to DISPLAY with truncation of integer-part
      * with leading zeros after truncation
           MOVE 1 TO RESULT
           COMPUTE RESULT = 15 + RESULT + 2000 / RESULT
           IF RESULT NOT = 16
              DISPLAY "NOT [+20] 16: " RESULT.

           IF FENCE-A NOT = FENCE
             DISPLAY 'broken FENCE-A' UPON SYSERR.
           IF FENCE-B NOT = FENCE
             DISPLAY 'broken FENCE-B' UPON SYSERR.

           STOP RUN.