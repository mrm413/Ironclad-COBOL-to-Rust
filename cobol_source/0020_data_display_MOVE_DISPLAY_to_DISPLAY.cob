IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  D-S99V99     PIC S99V99 DISPLAY VALUE  1.23.
       01  D-N99V99     PIC S99V99 DISPLAY VALUE -1.32.
       01  D-9V99       PIC   9V99 DISPLAY VALUE  1.1.
       01  D-S99        PIC S99    DISPLAY VALUE  12.
       01  D-99         PIC  99    DISPLAY VALUE  2.
       01  D-P99        PIC P99    DISPLAY VALUE  0.02.
       01  D-9PP        PIC 9PP    DISPLAY VALUE  200.
       01  T-S99V99     PIC S99V99 DISPLAY.
       01  T-99V9       PIC  99V9  DISPLAY.
       01  T-S999       PIC S999   DISPLAY.
       01  T-99         PIC  99    DISPLAY.
       01  T-P9         PIC  P9    DISPLAY.
       01  T-9P         PIC  9P    DISPLAY.
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.

       PROCEDURE        DIVISION.
       MAIN.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 20000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.

           MOVE D-S99V99 TO T-S99V99
           IF T-S99V99 NOT = 1.23
              DISPLAY "T-S99V99 1: " T-S99V99.
           MOVE D-N99V99 TO T-S99V99
           IF T-S99V99 NOT = -1.32
              DISPLAY "T-S99V99 2: " T-S99V99.
           MOVE D-9V99   TO T-S99V99
           IF T-S99V99 NOT = 1.1
              DISPLAY "T-S99V99 3: " T-S99V99.
           MOVE D-S99    TO T-S99V99
           IF T-S99V99 NOT = 12
              DISPLAY "T-S99V99 4: " T-S99V99.
           MOVE D-99     TO T-S99V99
           IF T-S99V99 NOT = 2
              DISPLAY "T-S99V99 5: " T-S99V99.
           MOVE D-P99    TO T-S99V99
           IF T-S99V99 NOT = 0.02
              DISPLAY "T-S99V99 6: " T-S99V99.
           MOVE D-9PP    TO T-S99V99
           IF T-S99V99 NOT = 0
              DISPLAY "T-S99V99 7: " T-S99V99.

           MOVE D-S99V99 TO T-99V9 
           IF T-99V9  NOT = 1.2
              DISPLAY "T-99V9   1: " T-99V9  .
           MOVE D-N99V99 TO T-99V9 
           IF T-99V9  NOT = 1.3
              DISPLAY "T-99V9   2: " T-99V9  .
           MOVE D-9V99   TO T-99V9 
           IF T-99V9  NOT = 1.1
              DISPLAY "T-99V9   3: " T-99V9  .
           MOVE D-S99    TO T-99V9 
           IF T-99V9  NOT = 12
              DISPLAY "T-99V9   4: " T-99V9  .
           MOVE D-99     TO T-99V9 
           IF T-99V9  NOT = 2
              DISPLAY "T-99V9   5: " T-99V9  .
           MOVE D-P99    TO T-99V9 
           IF T-99V9  NOT = 0
              DISPLAY "T-99V9   6: " T-99V9  .
           MOVE D-9PP    TO T-99V9 
           IF T-99V9  NOT = 0
              DISPLAY "T-99V9   7: " T-99V9  .

           MOVE D-S99V99 TO T-S999
           IF T-S999   NOT = 1
              DISPLAY "T-S999   1: " T-S999  .
           MOVE D-N99V99 TO T-S999
           IF T-S999   NOT = -1
              DISPLAY "T-S999   2: " T-S999  .
           MOVE D-9V99   TO T-S999
           IF T-S999   NOT = 1
              DISPLAY "T-S999   3: " T-S999  .
           MOVE D-S99    TO T-S999
           IF T-S999   NOT = 12
              DISPLAY "T-S999   4: " T-S999  .
           MOVE D-99     TO T-S999
           IF T-S999   NOT = 2
              DISPLAY "T-S999   5: " T-S999  .
           MOVE D-P99    TO T-S999
           IF T-S999   NOT = 0
              DISPLAY "T-S999   6: " T-S999  .
           MOVE D-9PP    TO T-S999
           IF T-S999   NOT = 200
              DISPLAY "T-S999   7: " T-S999  .

           MOVE D-S99V99 TO T-99
           IF T-99     NOT = 1
              DISPLAY "T-99     1: " T-99    .
           MOVE D-N99V99 TO T-99
           IF T-99     NOT = 1
              DISPLAY "T-99     2: " T-99    .
           MOVE D-9V99   TO T-99
           IF T-99     NOT = 1
              DISPLAY "T-99     3: " T-99    .
           MOVE D-S99    TO T-99
           IF T-99     NOT = 12
              DISPLAY "T-99     4: " T-99    .
           MOVE D-99     TO T-99
           IF T-99     NOT = 2
              DISPLAY "T-99     5: " T-99    .
           MOVE D-P99    TO T-99
           IF T-99     NOT = 0
              DISPLAY "T-99     6: " T-99    .
           MOVE D-9PP    TO T-99
           IF T-99     NOT = 0
              DISPLAY "T-99     7: " T-99    .

           MOVE D-S99V99 TO T-P9
           IF T-P9     NOT = 0.03
              DISPLAY "T-P9     1: " T-P9    .
           MOVE D-N99V99 TO T-P9
           IF T-P9     NOT = 0.02
              DISPLAY "T-P9     2: " T-P9    .
           MOVE D-9V99   TO T-P9
           IF T-P9     NOT = 0
              DISPLAY "T-P9     3: " T-P9    .
           MOVE D-S99    TO T-P9
           IF T-P9     NOT = 0
              DISPLAY "T-P9     4: " T-P9    .
           MOVE D-99     TO T-P9
           IF T-P9     NOT = 0
              DISPLAY "T-P9     5: " T-P9    .
           MOVE D-P99    TO T-P9
           IF T-P9     NOT = 0.02
              DISPLAY "T-P9     6: " T-P9    .
           MOVE D-9PP    TO T-P9
           IF T-P9     NOT = 0
              DISPLAY "T-P9     7: " T-P9    .

           MOVE D-S99V99 TO T-9P
           IF T-9P     NOT = 0
              DISPLAY "T-9P     1: " T-9P    .
           MOVE D-N99V99 TO T-9P
           IF T-9P     NOT = 0
              DISPLAY "T-9P     2: " T-9P    .
           MOVE D-9V99   TO T-9P
           IF T-9P     NOT = 0
              DISPLAY "T-9P     3: " T-9P    .
           MOVE D-S99    TO T-9P
           IF T-9P     NOT = 10
              DISPLAY "T-9P     4: " T-9P    .
           MOVE D-99     TO T-9P
           IF T-9P     NOT = 0
              DISPLAY "T-9P     5: " T-9P    .
           MOVE D-P99    TO T-9P
           IF T-9P     NOT = 0
              DISPLAY "T-9P     6: " T-9P    .
           MOVE D-9PP    TO T-9P
           IF T-9P     NOT = 0
              DISPLAY "T-9P     7: " T-9P    .

           CONTINUE.