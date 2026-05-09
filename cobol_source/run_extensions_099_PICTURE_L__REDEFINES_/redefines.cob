IDENTIFICATION   DIVISION.
       PROGRAM-ID.      redefines.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       1 W-DATA.
          2 UNUSED-1    PIC X VALUE "?".
          2 X-DAT       PICTURE X(10).
          2 Y1-DAT      REDEFINES X-DAT PICTURE LX(5) DEPENDING ON LGY.
          2 Y2-DAT      REDEFINES X-DAT PICTURE LX(5) DEPENDING ON LGY.
          2 UNUSED-2    PIC X VALUE "!".
          2 Z-DAT       PICTURE LX(7) DEPENDING ON LGZ.
          2 T-DAT       REDEFINES Z-DAT PICTURE LX(7) DEPENDING ON LGT.
          2 UNUSED-3    PIC X VALUE ".".
       1 W-LGS.
          2 LGX         PIC 99 VALUE 10.
          2 LGY         PIC 9 VALUE 5.
          2 LGZ         PIC 9 VALUE 7.
          2 LGT         PIC 9 VALUE 5.
       1 W-DATA2.
          2 W-X.
             3 W-TAB0.
                4 W-PREFIX PIC X(5).
                4          PIC X(5).
             3 W-TAB1   REDEFINES W-TAB0 PIC LX(10) DEPENDING LG-TAB1.
          2 LG-TAB1     COMP-1.
       PROCEDURE        DIVISION.
       MAIN.
           MOVE "......." TO Z-DAT
           MOVE 3 TO LGZ
           MOVE "0123456789" TO X-DAT
           IF Y1-DAT NOT EQUAL "01234" OR
              Y2-DAT NOT EQUAL "01234"
              DISPLAY "INITIAL MOVE FAILED"
              PERFORM SHOW-VARS
           END-IF
           MOVE "0123456" TO Z-DAT.
           IF T-DAT NOT EQUAL "012.." OR
              Z-DAT NOT EQUAL "012"
              DISPLAY "SECOND MOVE FAILED"
              PERFORM SHOW-VARS
           END-IF
      *    Initialize group containing PICTURE L field: curr. size should be ignored
           MOVE 1 TO LGZ
           INITIALIZE W-DATA
           MOVE 7 TO LGT
           IF T-DAT NOT EQUAL "       "
              DISPLAY "UNEXPECTED T-DAT AFTER 'INITIALIZE W-DATA': "
                       T-DAT
              PERFORM SHOW-VARS
           END-IF
      *    Initialize PICTURE L field: curr. size is ignored
           MOVE "???????" TO T-DAT
           INITIALIZE Z-DAT
           MOVE 2 TO LGZ
           IF T-DAT NOT EQUAL " ??????" OR
              Z-DAT NOT EQUAL " ?"
              DISPLAY "UNEXPECTED T-DAT/Z-DAT AFTER "
                       "'INITIALIZE Z-DAT': " T-DAT "/" Z-DAT "*"
              PERFORM SHOW-VARS
           END-IF
      *    Basic manipulation for late DEPENDING var
           MOVE "aaaaaaaaaa" TO W-TAB0
           MOVE 5 TO LG-TAB1
           IF W-TAB1 NOT EQUAL "aaaaa"
              DISPLAY "UNEXPECTED W-TAB1 WITH LATE L-VAR: *" W-TAB1 "*"
           END-IF
           IF W-X NOT EQUAL "aaaaaaaaaa"
              DISPLAY "UNEXPECTED W-X WITH NESTED LATE L-VAR: *" W-X "*"
           END-IF
           STOP RUN
           .
       SHOW-VARS.
           DISPLAY X-DAT "*" Y1-DAT "*" Y2-DAT "*" T-DAT "*" Z-DAT "*"
           .