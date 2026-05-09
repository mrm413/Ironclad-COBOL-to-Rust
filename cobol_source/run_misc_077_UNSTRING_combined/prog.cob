IDENTIFICATION DIVISION.
       PROGRAM-ID. UnstringTest.
      *>----------------------------------------------------------------
      *>           Additional test case for UNSTRING
      *> testing unstring tallying with and without OVERFLOW and with
      *> ALL clause for delimiters
      *>----------------------------------------------------------------
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *>-----------------------
       01 INP-STRING           PIC X(13) VALUE 'ABC1|DEF--GHI'.
       01 STR-POINTER          PIC 9(02).
       01 RES-DATA.
          05 RES-TRGT-1        PIC X(20).
          05 RES-DELIM-1       PIC X(01).
          05 RES-COUNT-1       PIC 9(02).
          05 RES-TRGT-2        PIC X(20).
          05 RES-DELIM-2       PIC X(01).
          05 RES-COUNT-2       PIC 9(02).
          05 RES-TALLY         PIC 9(02).
      *>
       PROCEDURE DIVISION.
      *>------------------
      *>
      *>   case A : should not  OVERFLOW; use of one delimiter
           INITIALIZE RES-DATA
           MOVE 1  TO STR-POINTER
      *>
           UNSTRING INP-STRING
                    DELIMITED BY '|'
               INTO RES-TRGT-1
                    DELIMITER IN RES-DELIM-1 COUNT IN RES-COUNT-1
                    RES-TRGT-2
                    DELIMITER IN RES-DELIM-2 COUNT IN RES-COUNT-2
               WITH POINTER STR-POINTER
               TALLYING RES-TALLY
               ON OVERFLOW
                   DISPLAY
                      'Unstring tallying case 1 should not OVERFLOW'
                   END-DISPLAY
           END-UNSTRING.
           PERFORM TEST-CASE-1-RESULT
      *>
      *>   case B : should  OVERFLOW; use of two delimiters
           INITIALIZE RES-DATA
           MOVE 1  TO STR-POINTER

           UNSTRING INP-STRING
                    DELIMITED BY '|' OR  ALL '-'
               INTO RES-TRGT-1
                    DELIMITER IN RES-DELIM-1 COUNT IN RES-COUNT-1
                    RES-TRGT-2
                    DELIMITER IN RES-DELIM-2 COUNT IN RES-COUNT-2
               WITH POINTER STR-POINTER
               TALLYING RES-TALLY
               NOT ON OVERFLOW
                   DISPLAY
                      'Unstring tallying case 2 should  OVERFLOW'
                   END-DISPLAY
           END-UNSTRING.
           PERFORM TEST-CASE-2-RESULT
      *>
           GOBACK.

      *>
       TEST-CASE-1-RESULT.
      *>------------------
           IF RES-TRGT-1 NOT = 'ABC1'
              DISPLAY 'A: RES-TRGT-1 <'   RES-TRGT-1  '> != <ABC1>'.
           IF RES-DELIM-1 NOT = '|'
              DISPLAY 'A: RES-DELIM-1 <'  RES-DELIM-1 '> != <|>'.
           IF RES-COUNT-1 NOT = 4
              DISPLAY 'A: RES-COUNT-1 <'  RES-COUNT-1 '> != <4>'.
           IF RES-TRGT-2 NOT = 'DEF--GHI'
              DISPLAY 'A: RES-TRGT-2 <'   RES-TRGT-2  '> != <DEF--GHI>'.
           IF RES-DELIM-2  NOT = SPACES
              DISPLAY 'A: RES-DELIM2 <'   RES-DELIM-2 '> != SPACE'.
           IF RES-COUNT-2 NOT = 8
              DISPLAY 'A: RES-COUNT-1 <'  RES-COUNT-2 '> != <8>'.
           IF STR-POINTER NOT = 14
              DISPLAY 'A: STR-POINTER <'  STR-POINTER '> != <14>'.
           IF RES-TALLY NOT = 2
              DISPLAY 'A: RES-TALLY <'    RES-TALLY   '> != <2>'.
      *>
       TEST-CASE-2-RESULT.
      *>------------------
           IF RES-TRGT-1 NOT = 'ABC1'
              DISPLAY 'B: RES-TRGT-1 <'   RES-TRGT-1  '> != <ABC1>'.
           IF RES-DELIM-1 NOT = '|'
              DISPLAY 'B: RES-DELIM-1 <'  RES-DELIM-1 '> != <|>'.
           IF RES-COUNT-1 NOT = 4
              DISPLAY 'B: RES-COUNT-1 <'  RES-COUNT-1 '> != <4>'.
           IF RES-TRGT-2 NOT = 'DEF'
              DISPLAY 'B: RES-TRGT-2 <'   RES-TRGT-2  '> != <DEF>'.
           IF RES-DELIM-2  NOT = '-'
              DISPLAY 'B: RES-DELIM2 <'   RES-DELIM-2 '> != <->'.
           IF RES-COUNT-2 NOT = 3
              DISPLAY 'B: RES-COUNT-1 <'  RES-COUNT-2 '> != <3>'.
           IF STR-POINTER NOT = 11
              DISPLAY 'B: STR-POINTER <'  STR-POINTER '> != <11>'.
           IF RES-TALLY NOT = 2
              DISPLAY 'B: RES-TALLY <'    RES-TALLY   '> != <2>'.