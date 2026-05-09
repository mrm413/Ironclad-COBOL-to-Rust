IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X-2         PIC X(2).
         02 N-2         REDEFINES X-2 PIC 999  USAGE PACKED-DECIMAL.
         02 N-S2        REDEFINES X-2 PIC S999 USAGE PACKED-DECIMAL.
       PROCEDURE        DIVISION.
           MOVE X"0000" TO X-2.
           IF N-2  IS NUMERIC
              DISPLAY " 0000 NG".
           IF N-S2 IS NUMERIC
              DISPLAY "S0000 NG".

           MOVE X"000c" TO X-2.
           IF N-2  IS NUMERIC
              DISPLAY " 000c NG".
           IF N-S2 IS NOT NUMERIC
              DISPLAY "S000c NG".

           MOVE X"000d" TO X-2.
           IF N-2  IS NUMERIC
              DISPLAY " 000d NG".
           IF N-S2 IS NOT NUMERIC
              DISPLAY "S000d NG".

           MOVE X"000f" TO X-2.
           IF N-2  IS NOT NUMERIC
              DISPLAY " 000f NG".
           IF N-S2 IS NUMERIC
              DISPLAY "S000f NG".

           MOVE X"1234" TO X-2.
           IF N-2  IS NUMERIC
              DISPLAY " 1234 NG".
           IF N-S2 IS NUMERIC
              DISPLAY "S1234 NG".

           MOVE X"999f" TO X-2.
           IF N-2  IS NOT NUMERIC
              DISPLAY " 999f NG".
           IF N-S2 IS NUMERIC
              DISPLAY "S999f NG".

           MOVE X"ffff" TO X-2.
           IF N-2  IS NUMERIC
              DISPLAY " ffff NG".
           IF N-S2 IS NUMERIC
              DISPLAY "Sffff NG".

           STOP RUN.