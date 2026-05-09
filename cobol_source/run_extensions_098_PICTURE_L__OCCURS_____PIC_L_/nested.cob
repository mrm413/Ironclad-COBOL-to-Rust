IDENTIFICATION   DIVISION.
       PROGRAM-ID.      nested.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       1 W-DATA.
         2 A            OCCURS 4
                        PICTURE LX(3) DEPENDING ON LGX.
         2 B            OCCURS 1 TO 10 DEPENDING ON LGY
                        PICTURE LX(3) DEPENDING ON LGX.
       1 LGX            USAGE COMP-1 VALUE 3.
       1 LGY            USAGE COMP-1 VALUE 4.
       PROCEDURE        DIVISION.
       MAIN.
           MOVE "AAAAAAAAAAAABBBBBBBBBBBB" TO W-DATA
           IF W-DATA NOT EQUAL "AAAAAAAAAAAABBBBBBBBBBBB" OR
              A (1)  NOT EQUAL "AAA"
              DISPLAY "GLOBAL INITIALIZATION FAILED"
              DISPLAY A (1)
              PERFORM SHOW-VARS
           END-IF
           MOVE "CCC" TO A (4)
           IF W-DATA NOT EQUAL "AAAAAAAAACCCBBBBBBBBBBBB" OR
              A (4)  NOT EQUAL "CCC"
              DISPLAY "MOVE TO A (4) FAILED"
              DISPLAY A (4)
              PERFORM SHOW-VARS
           END-IF
           MOVE A (3) TO B (2)
           IF W-DATA NOT EQUAL "AAAAAAAAACCCBBBAAABBBBBB" OR
              B (2)  NOT EQUAL "AAA"
              DISPLAY "MOVE A (3) TO B (2) FAILED"
              DISPLAY B (2)
              PERFORM SHOW-VARS
           END-IF
           MOVE 6 TO LGY
           MOVE 2 TO LGX
      *    Operand of 'INITIALIZE' may not have 'OCCURS DEPENDING ON':
      *    INITIALIZE B (5)
           MOVE SPACES TO B (5)
      *    *> NO ODOSLIDE: W-DATA EQUAL "AAAAAAAAACCCBBBAAABBBBBB      "
      *    *>    ODOSLIDE: W-DATA EQUAL "AAAAAAAAACCCBBBAAABB"
           IF A (3)  NOT EQUAL "AA" OR
              A (4)  NOT EQUAL "CC" OR
              B (4)  NOT EQUAL "BB" OR
              B (5)  NOT EQUAL "  "
              DISPLAY "MOVE 2,6 TO LGX,Y; INITIALIZE B (5); FAILED"
              PERFORM SHOW-VARS
           END-IF
           STOP RUN
           .
       SHOW-VARS.
           DISPLAY "W-DATA: *" W-DATA "*"
           DISPLAY "LGX: " LGX
           DISPLAY "LGY: " LGY
           .