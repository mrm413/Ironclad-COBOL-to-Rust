IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78 FENCE         VALUE x'ABBAAB'.
       01 FILLER.
         05 FENCE-1     PIC XXX VALUE FENCE.
         05 X-9         PIC 9     USAGE COMP-6.
         05 FENCE-2     PIC XXX VALUE FENCE.
         05 X-99        PIC 99    USAGE COMP-6.
         05 FENCE-3     PIC XXX VALUE FENCE.
         05 X-920       PIC 9(20) USAGE COMP-6.
         05 FENCE-4     PIC XXX VALUE FENCE.
         05 X-921       PIC 9(21) USAGE COMP-6.
         05 FENCE-5     PIC XXX VALUE FENCE.
       01 B-99          USAGE BINARY-LONG UNSIGNED VALUE 99.
       01 B-999         USAGE BINARY-LONG UNSIGNED VALUE 123.
       PROCEDURE        DIVISION.
           MOVE B-999 TO X-99
           IF X-99  <> 23 DISPLAY 'trunk 123 -> 99: 'X-99.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.

           MOVE B-999 TO X-9
           IF X-9   <> 3  DISPLAY 'trunk 123 -> 9: ' X-9.
           IF FENCE-1 NOT = FENCE
             MOVE FENCE TO FENCE-1
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.

           MOVE B-99  TO X-99
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.

           MOVE B-999 TO X-920
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.

           MOVE X-99  TO X-921
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.

           ADD  X-99  X-920 GIVING B-99.
           IF B-99  <> 222 DISPLAY '!222: ' B-99.
           IF X-920  > 124 DISPLAY '> 124 ' X-920.
           IF X-921  < 98  DISPLAY '< 98 '  X-921.

           IF FENCE-1 NOT = FENCE
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             DISPLAY 'broken FENCE-5' UPON SYSERR.
             
           STOP RUN.