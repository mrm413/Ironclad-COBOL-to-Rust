IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  P-S99V99     PIC S99V99 PACKED-DECIMAL VALUE  1.23.
       01  P-N99V99     PIC S99V99 PACKED-DECIMAL VALUE -1.32.
       01  P-9V99       PIC   9V99 PACKED-DECIMAL VALUE  1.1.
       01  P-S99        PIC S99    PACKED-DECIMAL VALUE  12.
       01  P-99         PIC  99    PACKED-DECIMAL VALUE  2.
       01  P-P99        PIC P99    PACKED-DECIMAL VALUE  0.02.
       01  P-9PP        PIC 9PP    PACKED-DECIMAL VALUE  200.
       01  P-938        PIC 9(38)  PACKED-DECIMAL VALUE
           12345678901234567890123456789012345678.
       01  D-S99V99     PIC S99V99 DISPLAY.
       01  D-99V9       PIC  99V9  DISPLAY.
       01  D-S999       PIC S999   DISPLAY.
       01  D-99         PIC  99    DISPLAY.
       01  D-P9         PIC  P9    DISPLAY.
       01  D-9P         PIC  9P    DISPLAY.
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

           MOVE P-938 TO D-99
           IF D-99     NOT = 78
              DISPLAY "D-99: " D-99.

           MOVE P-S99V99 TO D-S99V99
           IF D-S99V99 NOT = 1.23
              DISPLAY "D-S99V99 1: " D-S99V99.
           MOVE P-N99V99 TO D-S99V99
           IF D-S99V99 NOT = -1.32
              DISPLAY "D-S99V99 2: " D-S99V99.
           MOVE P-9V99   TO D-S99V99
           IF D-S99V99 NOT = 1.1
              DISPLAY "D-S99V99 3: " D-S99V99.
           MOVE P-S99    TO D-S99V99
           IF D-S99V99 NOT = 12
              DISPLAY "D-S99V99 4: " D-S99V99.
           MOVE P-99     TO D-S99V99
           IF D-S99V99 NOT = 2
              DISPLAY "D-S99V99 5: " D-S99V99.
           MOVE P-P99    TO D-S99V99
           IF D-S99V99 NOT = 0.02
              DISPLAY "D-S99V99 6: " D-S99V99.
           MOVE P-9PP    TO D-S99V99
           IF D-S99V99 NOT = 0
              DISPLAY "D-S99V99 7: " D-S99V99.

           MOVE P-S99V99 TO D-99V9
           IF D-99V9  NOT = 1.2
              DISPLAY "D-99V99  1: " D-99V9  .
           MOVE P-N99V99 TO D-99V9
           IF D-99V9  NOT = 1.3
              DISPLAY "D-99V99  2: " D-99V9  .
           MOVE P-9V99   TO D-99V9
           IF D-99V9  NOT = 1.1
              DISPLAY "D-99V99  3: " D-99V9  .
           MOVE P-S99    TO D-99V9
           IF D-99V9  NOT = 12
              DISPLAY "D-99V99  4: " D-99V9  .
           MOVE P-99     TO D-99V9
           IF D-99V9  NOT = 2
              DISPLAY "D-99V99  5: " D-99V9  .
           MOVE P-P99    TO D-99V9
           IF D-99V9  NOT = 0
              DISPLAY "D-99V99  6: " D-99V9  .
           MOVE P-9PP    TO D-99V9
           IF D-99V9  NOT = 0
              DISPLAY "D-99V99  7: " D-99V9  .

           MOVE P-S99V99 TO D-S999
           IF D-S999   NOT = 1
              DISPLAY "D-S999   1: " D-S999  .
           MOVE P-N99V99 TO D-S999
           IF D-S999   NOT = -1
              DISPLAY "D-S999   2: " D-S999  .
           MOVE P-9V99   TO D-S999
           IF D-S999   NOT = 1
              DISPLAY "D-S999   3: " D-S999  .
           MOVE P-S99    TO D-S999
           IF D-S999   NOT = 12
              DISPLAY "D-S999   4: " D-S999  .
           MOVE P-99     TO D-S999
           IF D-S999   NOT = 2
              DISPLAY "D-S999   5: " D-S999  .
           MOVE P-P99    TO D-S999
           IF D-S999   NOT = 0
              DISPLAY "D-S999   6: " D-S999  .
           MOVE P-9PP    TO D-S999
           IF D-S999   NOT = 200
              DISPLAY "D-S999   7: " D-S999  .

           MOVE P-S99V99 TO D-99
           IF D-99     NOT = 1
              DISPLAY "D-99     1: " D-99    .
           MOVE P-N99V99 TO D-99
           IF D-99     NOT = 1
              DISPLAY "D-99     2: " D-99    .
           MOVE P-9V99   TO D-99
           IF D-99     NOT = 1
              DISPLAY "D-99     3: " D-99    .
           MOVE P-S99    TO D-99
           IF D-99     NOT = 12
              DISPLAY "D-99     4: " D-99    .
           MOVE P-99     TO D-99
           IF D-99     NOT = 2
              DISPLAY "D-99     5: " D-99    .
           MOVE P-P99    TO D-99
           IF D-99     NOT = 0
              DISPLAY "D-99     6: " D-99    .
           MOVE P-9PP    TO D-99
           IF D-99     NOT = 0
              DISPLAY "D-99     7: " D-99    .

           MOVE P-S99V99 TO D-P9
           IF D-P9     NOT = 0.03
              DISPLAY "D-P9     1: " D-P9    .
           MOVE P-N99V99 TO D-P9
           IF D-P9     NOT = 0.02
              DISPLAY "D-P9     2: " D-P9    .
           MOVE P-9V99   TO D-P9
           IF D-P9     NOT = 0
              DISPLAY "D-P9     3: " D-P9    .
           MOVE P-S99    TO D-P9
           IF D-P9     NOT = 0
              DISPLAY "D-P9     4: " D-P9    .
           MOVE P-99     TO D-P9
           IF D-P9     NOT = 0
              DISPLAY "D-P9     5: " D-P9    .
           MOVE P-P99    TO D-P9
           IF D-P9     NOT = 0.02
              DISPLAY "D-P9     6: " D-P9    .
           MOVE P-9PP    TO D-P9
           IF D-P9     NOT = 0
              DISPLAY "D-P9     7: " D-P9    .

           MOVE P-S99V99 TO D-9P
           IF D-9P     NOT = 0
              DISPLAY "D-9P     1: " D-9P    .
           MOVE P-N99V99 TO D-9P
           IF D-9P     NOT = 0
              DISPLAY "D-9P     2: " D-9P    .
           MOVE P-9V99   TO D-9P
           IF D-9P     NOT = 0
              DISPLAY "D-9P     3: " D-9P    .
           MOVE P-S99    TO D-9P
           IF D-9P     NOT = 10
              DISPLAY "D-9P     4: " D-9P    .
           MOVE P-99     TO D-9P
           IF D-9P     NOT = 0
              DISPLAY "D-9P     5: " D-9P    .
           MOVE P-P99    TO D-9P
           IF D-9P     NOT = 0
              DISPLAY "D-9P     6: " D-9P    .
           MOVE P-9PP    TO D-9P
           IF D-9P     NOT = 0
              DISPLAY "D-9P     7: " D-9P    .

           CONTINUE.