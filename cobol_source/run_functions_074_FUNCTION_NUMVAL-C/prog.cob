IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X1     PIC   X(14) VALUE " % -9876.1234 ".
       01  X2     PIC   X(18) VALUE " % 19,876.1234 DB".
       01  X2b    PIC   X(18) VALUE " % 19,876.1234 db".
       01  X2c    PIC   X(18) VALUE " % 19,876.1234 Db".
       01  X2d    PIC   X(18) VALUE " % 19,876.1234 dB".
       01  X3     PIC   X(12) VALUE "% -9876.1234".
       01  X4     PIC   X(12) VALUE "019,876.1234".
       01  BAD1   PIC   X(18) VALUE " -19,876.1234 %".
       01  BAD2   PIC   X(18) VALUE "19,87,56.12.34 ".
       01  BAD3   PIC   X(18) VALUE "+19,8756CR1234".
       01  N      PIC   s9(8)v9(5).
       PROCEDURE        DIVISION.
           MOVE FUNCTION NUMVAL-C ( X1 , "%" ) TO N
           IF N NOT = -9876.1234
              DISPLAY "X1 '" X1 "' : " N.
           MOVE FUNCTION NUMVAL-C ( X2 , "%" ) TO N
           IF N NOT = -19876.1234
              DISPLAY "X2 '" X2 "' : " N
           ELSE IF N
            <> FUNCTION NUMVAL ( X2b )
           OR  N
            <> FUNCTION NUMVAL ( X2c )
           OR  N
            <> FUNCTION NUMVAL ( X2d )
              DISPLAY "NUMVAL not case-insensitive!".
           MOVE FUNCTION NUMVAL-C ( X3 , "%" ) TO N
           IF N NOT = -9876.1234
              DISPLAY "X3 '" X3 "' : " N.
           MOVE FUNCTION NUMVAL-C ( X4 , "%" ) TO N
           IF N NOT = 19876.1234
              DISPLAY "X4 '" X4 "' : " N.

      *    Note: the following tests with invalid data, pre 3.2
      *          return zero, 3.2+ get "whatever is valid there
      *          (which seem to be what MF is doing)
           MOVE FUNCTION NUMVAL ( BAD1 ) TO N
           IF N <> 0 AND N <> -19876.1234
              DISPLAY "BAD1 '" BAD1 "' : " N.
           MOVE FUNCTION NUMVAL ( BAD2 ) TO N
           IF N <> 0 AND N <> 198756.1234
              DISPLAY "BAD2 '" BAD2 "' : " N.
           MOVE FUNCTION NUMVAL ( BAD3 ) TO N
           IF N <> 0 AND N <> -198756
              DISPLAY "BAD3 '" BAD3 "' : " N.
           STOP RUN.