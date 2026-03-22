IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X   PIC      X(4).
       01  Z   PIC      N(4).
       01  TEST-FLD     PIC S9(04)V9(08).
       PROCEDURE        DIVISION.
           MOVE FUNCTION BYTE-LENGTH ( X )
             TO TEST-FLD.
           IF TEST-FLD NOT = 4
              DISPLAY 'BYTE-LENGTH X(4) wrong: ' TEST-FLD.
           MOVE FUNCTION BYTE-LENGTH ( Z )
             TO TEST-FLD
           IF TEST-FLD NOT = 8
              DISPLAY 'BYTE-LENGTH N(4) wrong: ' TEST-FLD.

           MOVE FUNCTION BYTE-LENGTH ( '00128' )
             TO TEST-FLD
           IF TEST-FLD NOT = 5
              DISPLAY 'BYTE-LENGTH "00128" wrong: ' TEST-FLD.
      *    note: we currently do not support items of category boolean...
      *>   MOVE FUNCTION BYTE-LENGTH ( b'100' )
      *>     TO TEST-FLD
      *>   IF TEST-FLD NOT = 3
      *>      DISPLAY 'BYTE-LENGTH b"100" wrong: ' TEST-FLD.
           MOVE FUNCTION BYTE-LENGTH ( x'a0' )
             TO TEST-FLD
           IF TEST-FLD NOT = 1
              DISPLAY 'BYTE-LENGTH x"a0" wrong: ' TEST-FLD.
           MOVE FUNCTION BYTE-LENGTH ( z'a0' )
             TO TEST-FLD
           IF TEST-FLD NOT = 3
              DISPLAY 'BYTE-LENGTH z"a0" wrong: ' TEST-FLD.
      *    we currently generate national constants as
      *    alphanumeric constants...
      *    MOVE FUNCTION BYTE-LENGTH ( n'a0' )
      *      TO TEST-FLD
      *    IF TEST-FLD NOT = 4
      *       DISPLAY 'BYTE-LENGTH n"a0" wrong: ' TEST-FLD.

           STOP RUN.