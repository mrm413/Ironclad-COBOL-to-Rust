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
       01  B-S99V99     PIC S99V99 BINARY.
       01  B-99V9       PIC  99V9  BINARY.
       01  B-S999       PIC S999   BINARY.
       01  B-99         PIC  99    BINARY.
       01  B-P9         PIC  P9    BINARY.
       01  B-9P         PIC  9P    BINARY.
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
       
           MOVE P-938 TO B-99
           IF B-99     NOT = 78
              DISPLAY "B-99: " B-99.

           MOVE P-S99V99 TO B-S99V99
           IF B-S99V99 NOT = 1.23
              DISPLAY "B-S99V99 1: " B-S99V99.
           MOVE P-N99V99 TO B-S99V99
           IF B-S99V99 NOT = -1.32
              DISPLAY "B-S99V99 2: " B-S99V99.
           MOVE P-9V99   TO B-S99V99
           IF B-S99V99 NOT = 1.1
              DISPLAY "B-S99V99 3: " B-S99V99.
           MOVE P-S99    TO B-S99V99
           IF B-S99V99 NOT = 12
              DISPLAY "B-S99V99 4: " B-S99V99.
           MOVE P-99     TO B-S99V99
           IF B-S99V99 NOT = 2
              DISPLAY "B-S99V99 5: " B-S99V99.
           MOVE P-P99    TO B-S99V99
           IF B-S99V99 NOT = 0.02
              DISPLAY "B-S99V99 6: " B-S99V99.
           MOVE P-9PP    TO B-S99V99
           IF B-S99V99 NOT = 0
              DISPLAY "B-S99V99 7: " B-S99V99.

           MOVE P-S99V99 TO B-99V9 
           IF B-99V9  NOT = 1.2
              DISPLAY "B-99V99  1: " B-99V9  .
           MOVE P-N99V99 TO B-99V9 
           IF B-99V9  NOT = 1.3
              DISPLAY "B-99V99  2: " B-99V9  .
           MOVE P-9V99   TO B-99V9 
           IF B-99V9  NOT = 1.1
              DISPLAY "B-99V99  3: " B-99V9  .
           MOVE P-S99    TO B-99V9 
           IF B-99V9  NOT = 12
              DISPLAY "B-99V99  4: " B-99V9  .
           MOVE P-99     TO B-99V9 
           IF B-99V9  NOT = 2
              DISPLAY "B-99V99  5: " B-99V9  .
           MOVE P-P99    TO B-99V9 
           IF B-99V9  NOT = 0
              DISPLAY "B-99V99  6: " B-99V9  .
           MOVE P-9PP    TO B-99V9 
           IF B-99V9  NOT = 0
              DISPLAY "B-99V99  7: " B-99V9  .

           MOVE P-S99V99 TO B-S999
           IF B-S999   NOT = 1
              DISPLAY "B-S999   1: " B-S999  .
           MOVE P-N99V99 TO B-S999
           IF B-S999   NOT = -1
              DISPLAY "B-S999   2: " B-S999  .
           MOVE P-9V99   TO B-S999
           IF B-S999   NOT = 1
              DISPLAY "B-S999   3: " B-S999  .
           MOVE P-S99    TO B-S999
           IF B-S999   NOT = 12
              DISPLAY "B-S999   4: " B-S999  .
           MOVE P-99     TO B-S999
           IF B-S999   NOT = 2
              DISPLAY "B-S999   5: " B-S999  .
           MOVE P-P99    TO B-S999
           IF B-S999   NOT = 0
              DISPLAY "B-S999   6: " B-S999  .
           MOVE P-9PP    TO B-S999
           IF B-S999   NOT = 200
              DISPLAY "B-S999   7: " B-S999  .

           MOVE P-S99V99 TO B-99
           IF B-99     NOT = 1
              DISPLAY "B-99     1: " B-99    .
           MOVE P-N99V99 TO B-99
           IF B-99     NOT = 1
              DISPLAY "B-99     2: " B-99    .
           MOVE P-9V99   TO B-99
           IF B-99     NOT = 1
              DISPLAY "B-99     3: " B-99    .
           MOVE P-S99    TO B-99
           IF B-99     NOT = 12
              DISPLAY "B-99     4: " B-99    .
           MOVE P-99     TO B-99
           IF B-99     NOT = 2
              DISPLAY "B-99     5: " B-99    .
           MOVE P-P99    TO B-99
           IF B-99     NOT = 0
              DISPLAY "B-99     6: " B-99    .
           MOVE P-9PP    TO B-99
           IF B-99     NOT = 0
              DISPLAY "B-99     7: " B-99    .

           MOVE P-S99V99 TO B-P9
           IF B-P9     NOT = 0.03
              DISPLAY "B-P9     1: " B-P9    .
           MOVE P-N99V99 TO B-P9
           IF B-P9     NOT = 0.02
              DISPLAY "B-P9     2: " B-P9    .
           MOVE P-9V99   TO B-P9
           IF B-P9     NOT = 0
              DISPLAY "B-P9     3: " B-P9    .
           MOVE P-S99    TO B-P9
           IF B-P9     NOT = 0
              DISPLAY "B-P9     4: " B-P9    .
           MOVE P-99     TO B-P9
           IF B-P9     NOT = 0
              DISPLAY "B-P9     5: " B-P9    .
           MOVE P-P99    TO B-P9
           IF B-P9     NOT = 0.02
              DISPLAY "B-P9     6: " B-P9    .
           MOVE P-9PP    TO B-P9
           IF B-P9     NOT = 0
              DISPLAY "B-P9     7: " B-P9    .

           MOVE P-S99V99 TO B-9P
           IF B-9P     NOT = 0
              DISPLAY "B-9P     1: " B-9P    .
           MOVE P-N99V99 TO B-9P
           IF B-9P     NOT = 0
              DISPLAY "B-9P     2: " B-9P    .
           MOVE P-9V99   TO B-9P
           IF B-9P     NOT = 0
              DISPLAY "B-9P     3: " B-9P    .
           MOVE P-S99    TO B-9P
           IF B-9P     NOT = 10
              DISPLAY "B-9P     4: " B-9P    .
           MOVE P-99     TO B-9P
           IF B-9P     NOT = 0
              DISPLAY "B-9P     5: " B-9P    .
           MOVE P-P99    TO B-9P
           IF B-9P     NOT = 0
              DISPLAY "B-9P     6: " B-9P    .
           MOVE P-9PP    TO B-9P
           IF B-9P     NOT = 0
              DISPLAY "B-9P     7: " B-9P    .

           CONTINUE.