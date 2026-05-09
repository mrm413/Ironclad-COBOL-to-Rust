IDENTIFICATION   DIVISION.
       PROGRAM-ID.      corr.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       1 W-DATA.
         2 GA.
           3 X          PICTURE X VALUE "X".
           3 YZ         PICTURE XX VALUE "YZ".
           3 X1         PICTURE LX(5) DEPENDING ON LGX.
         2 GB.
           3 X1         PICTURE LX(5) DEPENDING ON LGX.
           3 X          PICTURE X VALUE SPACE.
         2 GC.
           3 X1         PICTURE X(5) VALUE "+++++".
       1 LGX            USAGE COMP-1 VALUE 5.
       1 CNT            USAGE COMP-1.
       PROCEDURE        DIVISION.
       MAIN.
           MOVE "AAAAA" TO X1 OF GA
           MOVE "BBBBB" TO X1 OF GB
           IF X1 OF GA NOT EQUAL "AAAAA" OR
              X1 OF GB NOT EQUAL "BBBBB"
              DISPLAY "GLOBAL INITIALIZATION FAILED"
              PERFORM SHOW-VARS
           END-IF
           MOVE 2 TO LGX
           IF W-DATA NOT EQUAL "XYZAAAAABBBBB +++++"
              DISPLAY "GROUP COMPARISON FAILED"
              DISPLAY GA
              PERFORM SHOW-VARS
           END-IF
      *    From basic to pic-l field: curr size should be ignored
           MOVE CORRESPONDING GC TO GA
           IF X1 OF GA NOT EQUAL "++" OR
              GA       NOT EQUAL "XYZ+++++"
              DISPLAY "MOVE CORRESPONDING GC TO GA: FAILED"
              PERFORM SHOW-VARS
           END-IF
      *    From pic-l to basic field: curr. size is ignored
           MOVE CORRESPONDING GB TO GC
           INSPECT X1 OF GC TALLYING CNT FOR ALL "B"
           IF X1 OF GC NOT EQUAL "BBBBB" OR
              CNT      NOT EQUAL 5
              DISPLAY "MOVE CORRESPONDING GB TO GC: FAILED"
              PERFORM SHOW-VARS
           END-IF
      *    From pic-l to pic-l: sizes are ignored
           MOVE CORRESPONDING GA TO GB
           MOVE 0 TO CNT
           INSPECT X1 OF GB TALLYING CNT FOR ALL "+"
           MOVE 5 TO LGX
           IF X1 OF GB NOT EQUAL "+++++" OR
              X  OF GB NOT EQUAL "X" OR
              CNT      NOT EQUAL 2
              DISPLAY "MOVE CORRESPONDING GA TO GB: FAILED"
              PERFORM SHOW-VARS
           END-IF
           STOP RUN
           .
       SHOW-VARS.
           DISPLAY "LGX: " LGX
           DISPLAY "W-DATA: *" W-DATA "*"
           DISPLAY "CNT: " CNT
           .