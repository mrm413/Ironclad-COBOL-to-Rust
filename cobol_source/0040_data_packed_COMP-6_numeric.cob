IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
          02 X-2         PIC X(2).
          02 N-3         REDEFINES X-2 PIC 999  USAGE COMP-6.
          02 N-4         REDEFINES X-2 PIC 9999 USAGE COMP-6.
       PROCEDURE        DIVISION.
           MOVE X"0000" TO X-2.
           IF N-3  IS NOT NUMERIC
              DISPLAY "3 0000 NG".
           IF N-4  IS NOT NUMERIC
              DISPLAY "4 0000 NG".

           MOVE X"000c" TO X-2.
           IF N-3  IS NUMERIC
              DISPLAY "3 000c NG".
           IF N-4  IS NUMERIC
              DISPLAY "4 000c NG".

           MOVE X"1234" TO X-2.
           IF N-3  IS NOT NUMERIC
              DISPLAY "3 1234 NG".
           IF N-4  IS NOT NUMERIC
              DISPLAY "4 1234 NG".

           MOVE X"ffff" TO X-2.
           IF N-3  IS NUMERIC
              DISPLAY "3 ffff NG".
           IF N-4  IS NUMERIC
              DISPLAY "4 ffff NG".

           STOP RUN.