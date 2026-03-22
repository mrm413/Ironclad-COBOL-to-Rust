IDENTIFICATION DIVISION.
       PROGRAM-ID. StringTest.
      *>----------------------------------------------------------------
      *>           Additional test cases for STRING statement
      *> Testing string  with POINTER clause and with OVERFLOW
      *> managment associated to POINTER clause
      *> Testing also String with delimiter
      *>----------------------------------------------------------------
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *>-----------------------
       01  TRGT-STRING   PIC X(03) VALUE SPACES.
       01  STR-POINTER   PIC 9(02).
       01  SRC-DELIM     PIC X(01).

       PROCEDURE DIVISION.
      *>-------------------
      *>
      *> case A: Pointer is between 1 and less than TRGT-STRING LENGTH
      *>         Should not overflow
            MOVE 1 to STR-POINTER.
            STRING 'A' 'B' 'C' DELIMITED BY SIZE
                   INTO TRGT-STRING
                   WITH POINTER STR-POINTER
                   ON OVERFLOW
                      DISPLAY 'Case A: Should not overflow' END-DISPLAY
            END-STRING.
            IF TRGT-STRING NOT = 'ABC'
                DISPLAY 'A: TRTG-STRING <' TRGT-STRING '> != <ABC>'.
            IF STR-POINTER NOT = 4
                DISPLAY 'A: STR-POINTER <' STR-POINTER '> != <04>'.
      *>
      *>  case B: Pointer is 0 --> Should  overflow
            MOVE 0                        TO STR-POINTER.
            MOVE SPACES                   TO TRGT-STRING.
            STRING 'A' 'B' 'C'  DELIMITED BY SIZE
                   INTO TRGT-STRING
                   WITH POINTER STR-POINTER
                   NOT ON OVERFLOW
                      DISPLAY 'Case B: Should overflow' END-DISPLAY
            END-STRING.
            IF TRGT-STRING NOT = SPACES
                DISPLAY 'B: TRTG-STRING <' TRGT-STRING '> != SPACES'.
            IF STR-POINTER NOT = 0
                DISPLAY 'B: STR-POINTER <' STR-POINTER '> != <00>'.
      *>
      *>  case C: Pointer is 4 --> Should  overflow
            MOVE 4                        TO STR-POINTER.
            MOVE SPACES                   TO TRGT-STRING.
            STRING 'A' 'B' 'C' DELIMITED BY SIZE
                   INTO TRGT-STRING
                   WITH POINTER STR-POINTER
                   NOT ON OVERFLOW
                      DISPLAY 'Case C: Should overflow' END-DISPLAY
            END-STRING.
            IF TRGT-STRING NOT = SPACES
                DISPLAY 'C: TRTG-STRING <' TRGT-STRING '> != SPACES'.
            IF STR-POINTER NOT = 4
                DISPLAY 'C: STR-POINTER <' STR-POINTER '> != <04>'.
      *>
      *>  case D: Test with delimiter
            MOVE 1      TO STR-POINTER.
            MOVE '|'    TO SRC-DELIM.
            MOVE SPACES TO TRGT-STRING.
            STRING '1|2' 'A|B' 'C|D'   DELIMITED BY SRC-DELIM
                    INTO TRGT-STRING
                    WITH POINTER STR-POINTER
            END-STRING.
            IF TRGT-STRING NOT = '1AC'
                DISPLAY 'D: TRGT-STRING <' TRGT-STRING '> != <1AC>'.
      *>
            GOBACK.