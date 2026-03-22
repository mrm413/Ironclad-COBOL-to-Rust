IDENTIFICATION DIVISION.
       PROGRAM-ID. DivideExtent.
       DATA DIVISION.
      *>----------------------------------------------------------------
      *>   Cover the cob_div_quotient c FUNCTION
      *>   and complete all  divide_statement parser rules
      *>----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 W01-DIVIDES.
          05  RES-TAB          PIC S9(09) BINARY  OCCURS 3.
      *>
       PROCEDURE DIVISION.
      *>------------------
       TEST-FORMAT-1.
      *>-------------
      *> DIVIDE Format 1 DIVIDE INTO
      *> case 1 : should not size error
           MOVE 100 TO RES-TAB(1).
           MOVE 200 TO RES-TAB(2).
           MOVE 300 TO RES-TAB(3).
           DIVIDE 100 INTO
                      RES-TAB(1)
                      RES-TAB(2)
                      RES-TAB(3)
                ON SIZE ERROR
                    DISPLAY '1: Should not raised size error'
           END-DIVIDE.
           IF    RES-TAB(1)  NOT = 1
              OR RES-TAB(2)  NOT = 2
              OR RES-TAB(3)  NOT = 3
              DISPLAY 'F1.1: result <' RES-TAB(1) '> <' RES-TAB(2) '> <'
                                    RES-TAB(3) '> should be 1 2 3'.
      *> case 2 : should  size error
           MOVE 0    TO RES-TAB(1).
           MOVE 100  TO RES-TAB(2).
           MOVE 200  TO RES-TAB(3).
           DIVIDE RES-TAB(1) INTO
                      RES-TAB(2)
                      RES-TAB(3)
                 NOT ON SIZE ERROR
                    DISPLAY 'F1.2: Should raise size error'
           END-DIVIDE.
           IF    RES-TAB(1)  NOT = 0
              OR RES-TAB(2)  NOT = 100
              OR RES-TAB(3)  NOT = 200
              DISPLAY 'F1.2: result <' RES-TAB(1) '> <' RES-TAB(2) '> <'
                                     RES-TAB(3) '> should be 0 100 200'.
      *> case 3 : not rounded
           MOVE   100 TO RES-TAB(1).
           DIVIDE 2.19 INTO  RES-TAB(1)
                ON SIZE ERROR
                    DISPLAY 'F1.3: Should not raise size error'
           END-DIVIDE.
           IF RES-TAB(1) NOT = 45
              DISPLAY 'F1.3: result <' RES-TAB(1)  '> should be 45'.
      *> case 4 : rounded
           MOVE   100 TO RES-TAB(1).
           DIVIDE 2.19 INTO  RES-TAB(1) ROUNDED
                ON SIZE ERROR
                    DISPLAY 'F1.4: Should not raise size error'
           END-DIVIDE.
      *
           IF RES-TAB(1) NOT = 46
              DISPLAY 'F1.4: result <' RES-TAB(1)  '> should be 46'.
      *>
       TEST-FORMAT-2.
      *>-------------
      *> DIVIDE Format 2:
      *> DIVIDE STATEMENT WITH INTO AND GIVING PHRASE
           DIVIDE 10.2 INTO 100 GIVING RES-TAB(1)
                ON SIZE ERROR
                        DISPLAY 'F2.1: Should not raised size error'
           END-DIVIDE.
           IF RES-TAB(1) NOT = 9
              DISPLAY 'F2.1: result <' RES-TAB(1)  '> should be 9'.
           DIVIDE 10.5 INTO 100 GIVING RES-TAB(1) ROUNDED
                ON SIZE ERROR
                        DISPLAY 'F2.2: Should not raise size error'
           END-DIVIDE.
           IF RES-TAB(1) NOT = 10
              DISPLAY 'F2.2: result <' RES-TAB(1)  '> should be 10'.
           DIVIDE 10.6 INTO 100 GIVING RES-TAB(1) ROUNDED
                ON SIZE ERROR
                        DISPLAY 'F2.3: Should not raise size error'
           END-DIVIDE.
           IF RES-TAB(1) NOT = 9
              DISPLAY 'F2.3: result <' RES-TAB(1)  '> should be 9'.
      *>
       TEST-FORMAT-4.
      *>-------------
      *> DIVIDE Format 4:
      *> DIVIDE STATEMENT WITH INTO AND REMAINDER PHRASE
           DIVIDE 2 INTO 100 GIVING RES-TAB(1) REMAINDER RES-TAB(2).
           IF RES-TAB(1) NOT = 50 OR RES-TAB(2) NOT = 0
              DISPLAY 'F4.1: result <' RES-TAB(1) '> <' RES-TAB(2)
                        '> should be <50> <0>'.
           DIVIDE 3 INTO 100 GIVING RES-TAB(1) REMAINDER RES-TAB(2).
           IF RES-TAB(1) NOT = 33 OR RES-TAB(2) NOT = 1
              DISPLAY 'F4.1: result <' RES-TAB(1) '> <' RES-TAB(2)
                        '> should be <33> <1>'.
           MOVE 0 TO RES-TAB(1) RES-TAB(2) RES-TAB(3).
           DIVIDE RES-TAB(1) INTO 100
                  GIVING RES-TAB(2)
                  REMAINDER RES-TAB(3)
                NOT ON SIZE ERROR
                    DISPLAY 'F4.3: Should  raised size error'
           END-DIVIDE.
      *>
           GOBACK.