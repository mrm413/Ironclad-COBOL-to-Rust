IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  TST    PIC X(10) VALUE "abcdefghij".
       01  TST2.
           05  FILLER OCCURS 5000.
               10 T2-1    PIC X(11).
               10 T2-2    PIC X(22).
       01  LN     PIC 9(06).

       PROCEDURE DIVISION.
           SET LN TO SIZE OF TST
           IF LN NOT = 10
              DISPLAY "SIZE OF TST is " LN UPON SYSERR
              END-DISPLAY
           END-IF
           SET LN TO SIZE OF TST2
           IF LN NOT = 165000
              DISPLAY "SIZE OF TST2 is " LN UPON SYSERR
              END-DISPLAY
           END-IF
           STOP RUN.