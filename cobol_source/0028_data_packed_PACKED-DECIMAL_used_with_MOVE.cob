IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78 FENCE         VALUE x'ABBAAB'.
       01 FILLER.
         05 FENCE-1     PIC XXX VALUE FENCE.
         05 X-99        PIC 99    USAGE PACKED-DECIMAL.
         05 FENCE-2     PIC XXX VALUE FENCE.
         05 X-S99       PIC S99   USAGE PACKED-DECIMAL.
         05 FENCE-3     PIC XXX VALUE FENCE.
         05 X-999       PIC 999   USAGE PACKED-DECIMAL.
         05 FENCE-4     PIC XXX VALUE FENCE.
         05 X-S999      PIC S999  USAGE PACKED-DECIMAL.
         05 FENCE-5     PIC XXX VALUE FENCE.
         05 X-CALC      PIC S9(09)V9(09) USAGE PACKED-DECIMAL.
         05 FENCE-6     PIC XXX VALUE FENCE.
       01 C-P234        PIC 999   VALUE 234.
       01 C-N234        PIC S999  VALUE -234.
       01 C-P1234       PIC 9999  VALUE 234.
       01 C-N1234       PIC S9999 VALUE -1234.
       01 B-P1234       USAGE BINARY-LONG VALUE 1234.
       01 B-N1234       USAGE BINARY-LONG VALUE -1234.
       PROCEDURE        DIVISION.
           MOVE C-P1234 TO X-99
           DISPLAY X-99.
           IF FENCE-1 NOT = FENCE
             MOVE FENCE TO FENCE-1
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.

           MOVE C-P1234 TO X-S99
           DISPLAY X-S99.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.

           MOVE C-P1234 TO X-999
           DISPLAY X-999.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.

           MOVE C-P1234 TO X-S999
           DISPLAY X-S999.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.

           MOVE C-N1234 TO X-99
           DISPLAY X-99.
           IF FENCE-1 NOT = FENCE
             MOVE FENCE TO FENCE-1
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.

           MOVE C-N1234 TO X-S99
           DISPLAY X-S99.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.

           MOVE C-N1234 TO X-999
           DISPLAY X-999.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.

           MOVE C-N1234 TO X-S999
           DISPLAY X-S999.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.

           MOVE B-N1234 TO X-999
           DISPLAY X-999.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.

           MOVE B-N1234 TO X-S999
           DISPLAY X-S999.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.

           MOVE C-P234  TO X-99
           DISPLAY X-99.
           IF FENCE-1 NOT = FENCE
             MOVE FENCE TO FENCE-1
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.

           MOVE C-P234  TO X-S99
           DISPLAY X-S99.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.

           MOVE C-P234  TO X-999
           DISPLAY X-999.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.

           MOVE C-P234  TO X-S999
           DISPLAY X-S999.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.

           MOVE C-N234  TO X-99
           DISPLAY X-99.
           IF FENCE-1 NOT = FENCE
             MOVE FENCE TO FENCE-1
             DISPLAY 'broken FENCE-1' UPON SYSERR.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.

           MOVE C-N234  TO X-S99
           DISPLAY X-S99.
           IF FENCE-2 NOT = FENCE
             MOVE FENCE TO FENCE-2
             DISPLAY 'broken FENCE-2' UPON SYSERR.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.

           MOVE C-N234  TO X-999
           DISPLAY X-999.
           IF FENCE-3 NOT = FENCE
             MOVE FENCE TO FENCE-3
             DISPLAY 'broken FENCE-3' UPON SYSERR.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.

           MOVE C-N234  TO X-S999
           DISPLAY X-S999.
           IF FENCE-4 NOT = FENCE
             MOVE FENCE TO FENCE-4
             DISPLAY 'broken FENCE-4' UPON SYSERR.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.

           MOVE ZERO  TO X-CALC
           DISPLAY X-CALC.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.
           IF FENCE-6 NOT = FENCE
             MOVE FENCE TO FENCE-6
             DISPLAY 'broken FENCE-6' UPON SYSERR.

           MOVE 1     TO X-CALC
           DISPLAY X-CALC.
           IF FENCE-5 NOT = FENCE
             MOVE FENCE TO FENCE-5
             DISPLAY 'broken FENCE-5' UPON SYSERR.
           IF FENCE-6 NOT = FENCE
             MOVE FENCE TO FENCE-6
             DISPLAY 'broken FENCE-6' UPON SYSERR.

           STOP RUN.