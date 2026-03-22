IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Datetime-Format CONSTANT "YYYYMMDDThhmmss.ss+hhmm".
       01  str             PIC X(25).
       PROCEDURE        DIVISION.
      *>   Test normal inputs.
           MOVE FUNCTION FORMATTED-CURRENT-DATE ( Datetime-Format )
             TO str
           IF FUNCTION TEST-FORMATTED-DATETIME ( Datetime-Format, str)
                   <> 0
              DISPLAY "Test 1 failed: " str END-DISPLAY
           END-IF.

           STOP RUN.