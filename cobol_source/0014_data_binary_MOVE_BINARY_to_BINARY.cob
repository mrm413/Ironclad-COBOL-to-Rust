IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  B-S99V99     PIC S99V99 BINARY VALUE  1.23.
       01  B-N99V99     PIC S99V99 BINARY VALUE -1.32.
       01  B-9V99       PIC   9V99 BINARY VALUE  1.1.
       01  B-S99        PIC S99    BINARY VALUE  12.
       01  B-99         PIC  99    BINARY VALUE  2.
       01  B-P99        PIC P99    BINARY VALUE  0.02.
       01  B-9PP        PIC 9PP    BINARY VALUE  200.
       01  C-S99V99     PIC S99V99 BINARY.
       01  C-99V9       PIC  99V9  BINARY.
       01  C-S999       PIC S999   BINARY.
       01  C-99         PIC  99    BINARY.
       01  C-P9         PIC  P9    BINARY.
       01  C-9P         PIC  9P    BINARY.
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

           MOVE B-S99V99 TO C-S99V99
           IF C-S99V99 NOT = 1.23
              DISPLAY "C-S99V99 1: " C-S99V99.
           MOVE B-N99V99 TO C-S99V99
           IF C-S99V99 NOT = -1.32
              DISPLAY "C-S99V99 2: " C-S99V99.
           MOVE B-9V99   TO C-S99V99
           IF C-S99V99 NOT = 1.1
              DISPLAY "C-S99V99 3: " C-S99V99.
           MOVE B-S99    TO C-S99V99
           IF C-S99V99 NOT = 12
              DISPLAY "C-S99V99 4: " C-S99V99.
           MOVE B-99     TO C-S99V99
           IF C-S99V99 NOT = 2
              DISPLAY "C-S99V99 5: " C-S99V99.
           MOVE B-P99    TO C-S99V99
           IF C-S99V99 NOT = 0.02
              DISPLAY "C-S99V99 6: " C-S99V99.
           MOVE B-9PP    TO C-S99V99
           IF C-S99V99 NOT = 0
              DISPLAY "C-S99V99 7: " C-S99V99.

           MOVE B-S99V99 TO C-99V9 
           IF C-99V9  NOT = 1.2
              DISPLAY "C-99V9   1: " C-99V9  .
           MOVE B-N99V99 TO C-99V9 
           IF C-99V9  NOT = 1.3
              DISPLAY "C-99V9   2: " C-99V9  .
           MOVE B-9V99   TO C-99V9 
           IF C-99V9  NOT = 1.1
              DISPLAY "C-99V9   3: " C-99V9  .
           MOVE B-S99    TO C-99V9 
           IF C-99V9  NOT = 12
              DISPLAY "C-99V9   4: " C-99V9  .
           MOVE B-99     TO C-99V9 
           IF C-99V9  NOT = 2
              DISPLAY "C-99V9   5: " C-99V9  .
           MOVE B-P99    TO C-99V9 
           IF C-99V9  NOT = 0
              DISPLAY "C-99V9   6: " C-99V9  .
           MOVE B-9PP    TO C-99V9 
           IF C-99V9  NOT = 0
              DISPLAY "C-99V9   7: " C-99V9  .

           MOVE B-S99V99 TO C-S999
           IF C-S999   NOT = 1
              DISPLAY "C-S999   1: " C-S999  .
           MOVE B-N99V99 TO C-S999
           IF C-S999   NOT = -1
              DISPLAY "C-S999   2: " C-S999  .
           MOVE B-9V99   TO C-S999
           IF C-S999   NOT = 1
              DISPLAY "C-S999   3: " C-S999  .
           MOVE B-S99    TO C-S999
           IF C-S999   NOT = 12
              DISPLAY "C-S999   4: " C-S999  .
           MOVE B-99     TO C-S999
           IF C-S999   NOT = 2
              DISPLAY "C-S999   5: " C-S999  .
           MOVE B-P99    TO C-S999
           IF C-S999   NOT = 0
              DISPLAY "C-S999   6: " C-S999  .
           MOVE B-9PP    TO C-S999
           IF C-S999   NOT = 200
              DISPLAY "C-S999   7: " C-S999  .

           MOVE B-S99V99 TO C-99
           IF C-99     NOT = 1
              DISPLAY "C-99     1: " C-99    .
           MOVE B-N99V99 TO C-99
           IF C-99     NOT = 1
              DISPLAY "C-99     2: " C-99    .
           MOVE B-9V99   TO C-99
           IF C-99     NOT = 1
              DISPLAY "C-99     3: " C-99    .
           MOVE B-S99    TO C-99
           IF C-99     NOT = 12
              DISPLAY "C-99     4: " C-99    .
           MOVE B-99     TO C-99
           IF C-99     NOT = 2
              DISPLAY "C-99     5: " C-99    .
           MOVE B-P99    TO C-99
           IF C-99     NOT = 0
              DISPLAY "C-99     6: " C-99    .
           MOVE B-9PP    TO C-99
           IF C-99     NOT = 0
              DISPLAY "C-99     7: " C-99    .

           MOVE B-S99V99 TO C-P9
           IF C-P9     NOT = 0.03
              DISPLAY "C-P9     1: " C-P9    .
           MOVE B-N99V99 TO C-P9
           IF C-P9     NOT = 0.02
              DISPLAY "C-P9     2: " C-P9    .
           MOVE B-9V99   TO C-P9
           IF C-P9     NOT = 0
              DISPLAY "C-P9     3: " C-P9    .
           MOVE B-S99    TO C-P9
           IF C-P9     NOT = 0
              DISPLAY "C-P9     4: " C-P9    .
           MOVE B-99     TO C-P9
           IF C-P9     NOT = 0
              DISPLAY "C-P9     5: " C-P9    .
           MOVE B-P99    TO C-P9
           IF C-P9     NOT = 0.02
              DISPLAY "C-P9     6: " C-P9    .
           MOVE B-9PP    TO C-P9
           IF C-P9     NOT = 0
              DISPLAY "C-P9     7: " C-P9    .

           MOVE B-S99V99 TO C-9P
           IF C-9P     NOT = 0
              DISPLAY "C-9P     1: " C-9P    .
           MOVE B-N99V99 TO C-9P
           IF C-9P     NOT = 0
              DISPLAY "C-9P     2: " C-9P    .
           MOVE B-9V99   TO C-9P
           IF C-9P     NOT = 0
              DISPLAY "C-9P     3: " C-9P    .
           MOVE B-S99    TO C-9P
           IF C-9P     NOT = 10
              DISPLAY "C-9P     4: " C-9P    .
           MOVE B-99     TO C-9P
           IF C-9P     NOT = 0
              DISPLAY "C-9P     5: " C-9P    .
           MOVE B-P99    TO C-9P
           IF C-9P     NOT = 0
              DISPLAY "C-9P     6: " C-9P    .
           MOVE B-9PP    TO C-9P
           IF C-9P     NOT = 0
              DISPLAY "C-9P     7: " C-9P    .

           CONTINUE.