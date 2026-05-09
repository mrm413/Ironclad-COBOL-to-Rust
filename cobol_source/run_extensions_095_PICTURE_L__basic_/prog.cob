IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       1 W-DATA.
         2 X-DAT       PICTURE LX(10) DEPENDING ON LGX.
         2 X-ALPHA     PICTURE LA(10) DEPENDING ON LGX.
         2 Y-DAT       PICTURE LX(9) DEPENDING ON LGY.
         2 Y-ALPHA     PICTURE LA(9) DEPENDING ON LGY.
       1 W-NESTED.
         2 X-GRP.
           3 X-0       PICTURE X VALUE "0".
           3 X-V       PICTURE LX(10) DEPENDING ON LGX.
           3 X-1       PICTURE X VALUE "1".
       1 W-LGS.
          2 LGX        USAGE COMP-1 VALUE 10.
          2 LGY        PICTURE 9 VALUE 9.
       1 W-LATE-LVAR.
         2 Z-GRP.
           3 Z-V       PICTURE LX(2) DEPENDING ON LGZ.
           3 UNUSED-0  PICTURE X VALUE "1".
         2 LGZ         PICTURE 9 VALUE 2.
       1 W-LEN          USAGE COMP-1.
       PROCEDURE        DIVISION.
       MAIN.
           MOVE SPACES TO W-DATA
           MOVE SPACES TO X-V
           IF X-DAT   NOT EQUAL "          " OR
              X-ALPHA NOT EQUAL "          " OR
              Y-DAT   NOT EQUAL "         " OR
              Y-ALPHA NOT EQUAL "         "
              DISPLAY "GROUP INITIALIZATION WITH SPACES FAILED"
              PERFORM SHOW-VARS
           END-IF
           MOVE 5 TO LGX
           MOVE 1 TO LGY
           IF W-DATA NOT EQUAL "                                      "
              DISPLAY "GROUP COMPARISON FAILED (W-DATA)"
              PERFORM SHOW-VARS
           END-IF
           IF W-NESTED NOT EQUAL "0          1" OR
              X-GRP    NOT EQUAL W-NESTED       OR
              X-V      NOT EQUAL "     "
              DISPLAY "GROUP COMPARISON FAILED (W-NESTED)"
              PERFORM SHOW-VARS
           END-IF
           MOVE ".........." TO X-DAT
           MOVE "XXXXXXXXXX" TO X-ALPHA
           MOVE "999999999" TO Y-DAT
           MOVE "AAAAAAAAA" TO Y-ALPHA
           IF X-DAT   NOT EQUAL "....." OR
              X-ALPHA NOT EQUAL "XXXXX" OR
              Y-DAT   NOT EQUAL "9" OR
              Y-ALPHA NOT EQUAL "A"
              DISPLAY "MOVES FROM LITERALS FAILED"
              PERFORM SHOW-VARS
           END-IF
           MOVE X-DAT TO Y-DAT
           MOVE Y-ALPHA TO X-ALPHA
           IF X-DAT   NOT EQUAL "....." OR
              X-ALPHA NOT EQUAL "A    " OR
              Y-DAT   NOT EQUAL "." OR
              Y-ALPHA NOT EQUAL "A"
              DISPLAY "MOVES FROM/TO VARS FAILED"
              PERFORM SHOW-VARS
           END-IF
           MOVE "AAAAA" TO X-ALPHA
           MOVE 1 TO LGX
           INITIALIZE X-ALPHA
           MOVE 10 TO LGX
           IF X-ALPHA NOT EQUAL " AAAA     "
              DISPLAY "DIRECT VAR INITIALIZATION FAILED"
              PERFORM SHOW-VARS
           END-IF
           MOVE 1 TO LGX
           COMPUTE W-LEN = LENGTH OF X-DAT
           IF W-LEN NOT EQUAL 10
              DISPLAY "UNEXPECTED RESULT FOR 'LENGTH OF X-DAT': "
                     W-LEN
              PERFORM SHOW-VARS
           END-IF
           COMPUTE W-LEN = FUNCTION LENGTH (X-ALPHA)
           IF W-LEN NOT EQUAL 1
              DISPLAY "UNEXPECTED RESULT FOR 'FUNCTION LENGTH "
                      "(X-ALPHA)': " W-LEN
              PERFORM SHOW-VARS
           END-IF
           MOVE 9 TO LGY
           MOVE ALL "A" TO Y-ALPHA
           MOVE 5 TO LGY
           INITIALIZE Y-ALPHA
           MOVE 9 TO LGY
           IF Y-ALPHA NOT EQUAL "     AAAA"
              DISPLAY "UNEXPECTED RESULT AFTER 'MOVE ALL/INITIALIZE': "
                      Y-ALPHA
              PERFORM SHOW-VARS
           END-IF
           PERFORM CHECK-LATE-LVAR
           STOP RUN
           .
       SHOW-VARS.
           DISPLAY W-DATA "*"
           DISPLAY X-DAT "*" X-ALPHA "*" Y-DAT "*" Y-ALPHA "*"
           DISPLAY W-NESTED "*"
           DISPLAY X-GRP "*"
           DISPLAY X-V "*"
           .
       CHECK-LATE-LVAR.
           MOVE "aa" TO Z-GRP (1:2)
           MOVE 1 TO LGZ
           MOVE SPACES TO Z-V
           IF Z-GRP NOT EQUAL " a1"
              DISPLAY "UNEXPECTED Z-GRP WITH NESTED LATE L-VAR: "
                      "*" Z-GRP "*"
           END-IF
           .