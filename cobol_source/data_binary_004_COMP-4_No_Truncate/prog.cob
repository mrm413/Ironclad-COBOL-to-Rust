IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  RANDOM-ORIGIN-B                     PIC 9V99 COMP-4.
       01  RANDOM-TARGET-B                     PIC V99  COMP-4.
       01  RANDOM-ORIGIN-D                     PIC 9V99 DISPLAY.
       01  RANDOM-TARGET-D                     PIC V99  DISPLAY.
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==,
               ==END-DISPLAY== BY ==END-DISPLAY END-IF==.
       PROCEDURE        DIVISION.
       MAIN.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 30000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
           MOVE 0.12            TO RANDOM-ORIGIN-D
           MOVE RANDOM-ORIGIN-D TO RANDOM-TARGET-D
           MOVE 0.12            TO RANDOM-ORIGIN-B
           MOVE RANDOM-ORIGIN-B TO RANDOM-TARGET-B
           IF RANDOM-ORIGIN-D <> RANDOM-ORIGIN-B
             DISPLAY "ORIGIN 0.12 WRONG"
             END-DISPLAY
             DISPLAY "DISPLAY: " RANDOM-ORIGIN-D
                " !=  BINARY : " RANDOM-ORIGIN-B
             END-DISPLAY
           END-IF.
           IF RANDOM-TARGET-D <> RANDOM-TARGET-B
             DISPLAY "TARGET  .12 WRONG"
             END-DISPLAY
             DISPLAY "DISPLAY: " RANDOM-TARGET-D
                " !=  BINARY : " RANDOM-TARGET-B
             END-DISPLAY
           ELSE
             DISPLAY "Ok with " RANDOM-TARGET-D " == " RANDOM-TARGET-B
             END-DISPLAY
           END-IF.

           MOVE 9.85            TO RANDOM-ORIGIN-D
           MOVE RANDOM-ORIGIN-D TO RANDOM-TARGET-D
           MOVE 9.85            TO RANDOM-ORIGIN-B
           MOVE RANDOM-ORIGIN-B TO RANDOM-TARGET-B
           IF RANDOM-ORIGIN-D <> RANDOM-ORIGIN-B
             DISPLAY "ORIGIN 9.85 WRONG"
             END-DISPLAY
             DISPLAY "DISPLAY: " RANDOM-ORIGIN-D
                " !=  BINARY : " RANDOM-ORIGIN-B
             END-DISPLAY
           END-IF.
           IF RANDOM-TARGET-D <> RANDOM-TARGET-B
             DISPLAY "TARGET  .85 WRONG"
             END-DISPLAY
             DISPLAY "DISPLAY: " RANDOM-TARGET-D
                " !=  BINARY : " RANDOM-TARGET-B
             END-DISPLAY
           ELSE
             DISPLAY "Ok with " RANDOM-TARGET-D " == " RANDOM-TARGET-B
             END-DISPLAY
           END-IF.