IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 XS.
         05 X-1  PIC 999PPP COMP-5  VALUE 91000.
         05 X-2  PIC 999PPP COMP-5  VALUE 92000.
         05 X-3  PIC X VALUE "$".
         05 X-4  PIC VPPP999 COMP-5 VALUE 0.000128.
       01 D-1    PIC 999PPP  COMP-5 VALUE 95000.
       01 D-2    PIC 9999PP  COMP-5 VALUE 193000.
       PROCEDURE        DIVISION.
           DISPLAY "INIT X-1 : " X-1 " .".
           DISPLAY "INIT X-2 : " X-2 " .".
           DISPLAY "INIT X-4 : " X-4 " .".
           DISPLAY "INIT D-1 : " D-1 " .".
           MOVE D-1 TO X-2 X-1
           MOVE X-2 TO D-1.
           DISPLAY "MOVE X-1 : " X-1 " .".
           DISPLAY "MOVE X-2 : " X-2 " .".
           MOVE 0.000256 TO X-4
           DISPLAY "MOVE X-4 : " X-4 " .".
           DISPLAY "MOVE D-1 : " D-1 " .".
           MOVE D-2 TO X-2 X-1
           DISPLAY "MOVE X-1 : " X-1 ":" D-2 " .".
           DISPLAY "MOVE X-2 : " X-2 ":" D-2 " .".
           MOVE 98000   TO X-1.
           IF X-1 NOT = 98000
             DISPLAY "MOVE 98000 failed: " X-1.
           MOVE 98000   TO D-1
           IF D-1 NOT = 98000
             DISPLAY "MOVE 98000 failed: " D-1.
           ADD 1000 TO X-1
           IF X-1 NOT = 99000
             DISPLAY "+ 1000 failed: " X-1.
           SUBTRACT 4000 FROM X-1.
           IF X-1 NOT = 95000
             DISPLAY "- 4000 failed: " X-1.
           DIVIDE 3 INTO X-1.
           IF X-1 NOT = 31000
             DISPLAY "/ 3 failed: " X-1.
           MULTIPLY 2 BY X-1 GIVING X-1.
           IF X-1 NOT = 62000
             DISPLAY "* 2 failed: " X-1.
           STOP RUN.