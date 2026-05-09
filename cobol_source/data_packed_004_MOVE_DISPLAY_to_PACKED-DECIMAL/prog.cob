IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-S99V99     PIC S99V99 DISPLAY VALUE  1.23.
        05 FILLER PIC XX VALUE '34'.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-N99V99     PIC S99V99 DISPLAY VALUE -1.32.
        05 FILLER PIC XX VALUE '34'.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-9V99       PIC   9V99 DISPLAY VALUE  1.1.
        05 FILLER PIC XX VALUE '34'.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-S99        PIC S99    DISPLAY VALUE  12.
        05 FILLER PIC XX VALUE '34'.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-99         PIC  99    DISPLAY VALUE  2.
        05 FILLER PIC XX VALUE '34'.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-P99        PIC P99    DISPLAY VALUE  0.02.
        05 FILLER PIC XX VALUE '34'.
       01  FILLER.
        05 FILLER PIC XX VALUE '12'.
        05 D-9PP        PIC 9PP    DISPLAY VALUE  200.
        05 FILLER PIC XX VALUE '34'.
       01  P-S99V99     PIC S99V99 PACKED-DECIMAL.
       01  P-99V9       PIC  99V9  PACKED-DECIMAL.
       01  P-S999       PIC S999   PACKED-DECIMAL.
       01  P-99         PIC  99    PACKED-DECIMAL.
       01  P-P9         PIC  P9    PACKED-DECIMAL.
       01  P-9P         PIC  9P    PACKED-DECIMAL.
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

           MOVE D-S99V99 TO P-S99V99
           IF P-S99V99 NOT = 1.23
              DISPLAY "P-S99V99 1: " P-S99V99.
           MOVE D-N99V99 TO P-S99V99
           IF P-S99V99 NOT = -1.32
              DISPLAY "P-S99V99 2: " P-S99V99.
           MOVE D-9V99   TO P-S99V99
           IF P-S99V99 NOT = 1.1
              DISPLAY "P-S99V99 3: " P-S99V99.
           MOVE D-S99    TO P-S99V99
           IF P-S99V99 NOT = 12
              DISPLAY "P-S99V99 4: " P-S99V99.
           MOVE D-99     TO P-S99V99
           IF P-S99V99 NOT = 2
              DISPLAY "P-S99V99 5: " P-S99V99.
           MOVE D-P99    TO P-S99V99
           IF P-S99V99 NOT = 0.02
              DISPLAY "P-S99V99 6: " P-S99V99.
           MOVE D-9PP    TO P-S99V99
           IF P-S99V99 NOT = 0
              DISPLAY "P-S99V99 7: " P-S99V99.

           MOVE D-S99V99 TO P-99V9
           IF P-99V9  NOT = 1.2
              DISPLAY "P-99V9   1: " P-99V9  .
           MOVE D-N99V99 TO P-99V9
           IF P-99V9  NOT = 1.3
              DISPLAY "P-99V9   2: " P-99V9  .
           MOVE D-9V99   TO P-99V9
           IF P-99V9  NOT = 1.1
              DISPLAY "P-99V9   3: " P-99V9  .
           MOVE D-S99    TO P-99V9
           IF P-99V9  NOT = 12
              DISPLAY "P-99V9   4: " P-99V9  .
           MOVE D-99     TO P-99V9
           IF P-99V9  NOT = 2
              DISPLAY "P-99V9   5: " P-99V9  .
           MOVE D-P99    TO P-99V9
           IF P-99V9  NOT = 0
              DISPLAY "P-99V9   6: " P-99V9  .
           MOVE D-9PP    TO P-99V9
           IF P-99V9  NOT = 0
              DISPLAY "P-99V9   7: " P-99V9  .

           MOVE D-S99V99 TO P-S999
           IF P-S999   NOT = 1
              DISPLAY "P-S999   1: " P-S999  .
           MOVE D-N99V99 TO P-S999
           IF P-S999   NOT = -1
              DISPLAY "P-S999   2: " P-S999  .
           MOVE D-9V99   TO P-S999
           IF P-S999   NOT = 1
              DISPLAY "P-S999   3: " P-S999  .
           MOVE D-S99    TO P-S999
           IF P-S999   NOT = 12
              DISPLAY "P-S999   4: " P-S999  .
           MOVE D-99     TO P-S999
           IF P-S999   NOT = 2
              DISPLAY "P-S999   5: " P-S999  .
           MOVE D-P99    TO P-S999
           IF P-S999   NOT = 0
              DISPLAY "P-S999   6: " P-S999  .
           MOVE D-9PP    TO P-S999
           IF P-S999   NOT = 200
              DISPLAY "P-S999   7: " P-S999  .

           MOVE D-S99V99 TO P-99
           IF P-99     NOT = 1
              DISPLAY "P-99     1: " P-99    .
           MOVE D-N99V99 TO P-99
           IF P-99     NOT = 1
              DISPLAY "P-99     2: " P-99    .
           MOVE D-9V99   TO P-99
           IF P-99     NOT = 1
              DISPLAY "P-99     3: " P-99    .
           MOVE D-S99    TO P-99
           IF P-99     NOT = 12
              DISPLAY "P-99     4: " P-99    .
           MOVE D-99     TO P-99
           IF P-99     NOT = 2
              DISPLAY "P-99     5: " P-99    .
           MOVE D-P99    TO P-99
           IF P-99     NOT = 0
              DISPLAY "P-99     6: " P-99    .
           MOVE D-9PP    TO P-99
           IF P-99     NOT = 0
              DISPLAY "P-99     7: " P-99    .

           MOVE D-S99V99 TO P-P9
           IF P-P9     NOT = 0.03
              DISPLAY "P-P9     1: " P-P9    .
           MOVE D-N99V99 TO P-P9
           IF P-P9     NOT = 0.02
              DISPLAY "P-P9     2: " P-P9    .
           MOVE D-9V99   TO P-P9
           IF P-P9     NOT = 0
              DISPLAY "P-P9     3: " P-P9    .
           MOVE D-S99    TO P-P9
           IF P-P9     NOT = 0
              DISPLAY "P-P9     4: " P-P9    .
           MOVE D-99     TO P-P9
           IF P-P9     NOT = 0
              DISPLAY "P-P9     5: " P-P9    .
           MOVE D-P99    TO P-P9
           IF P-P9     NOT = 0.02
              DISPLAY "P-P9     6: " P-P9    .
           MOVE D-9PP    TO P-P9
           IF P-P9     NOT = 0
              DISPLAY "P-P9     7: " P-P9    .

           MOVE D-S99V99 TO P-9P
           IF P-9P     NOT = 0
              DISPLAY "P-9P     1: " P-9P    .
           MOVE D-N99V99 TO P-9P
           IF P-9P     NOT = 0
              DISPLAY "P-9P     2: " P-9P    .
           MOVE D-9V99   TO P-9P
           IF P-9P     NOT = 0
              DISPLAY "P-9P     3: " P-9P    .
           MOVE D-S99    TO P-9P
           IF P-9P     NOT = 10
              DISPLAY "P-9P     4: " P-9P    .
           MOVE D-99     TO P-9P
           IF P-9P     NOT = 0
              DISPLAY "P-9P     5: " P-9P    .
           MOVE D-P99    TO P-9P
           IF P-9P     NOT = 0
              DISPLAY "P-9P     6: " P-9P    .
           MOVE D-9PP    TO P-9P
           IF P-9P     NOT = 0
              DISPLAY "P-9P     7: " P-9P    .

           CONTINUE.