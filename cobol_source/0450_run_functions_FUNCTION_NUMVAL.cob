IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X1     PIC   X(12) VALUE " -9876.1234 ".
       01  X2     PIC   X(18) VALUE " 19876.1234 CR".
       01  X2b    PIC   X(18) VALUE " 19876.1234 cR".
       01  X2c    PIC   X(18) VALUE " 19876.1234 cr".
       01  X2d    PIC   X(18) VALUE " 19876.1234 Cr".
       01  X3     PIC   X(09) VALUE "-042.3240".
       01  X4     PIC   X(09) VALUE "+04232400".
       01  X5     PIC   X(09) VALUE " 00.00430".
       01  BAD1   PIC   X(18) VALUE " 1. A-0B4.5".
       01  BAD2   PIC   X(20) VALUE "+0@0%0=0*0!0&0^0)10-".
       01  EMPT   PIC   X(20) VALUE SPACE.
       77  CSZE   PIC   9     VALUE 0.
       01  VSIZED.
           03 FILLER  PIC X OCCURS 0 TO 10 DEPENDING ON CSZE.
       01  N      PIC   s9(8)v9(5).
       PROCEDURE        DIVISION.
           MOVE FUNCTION NUMVAL ( X1 ) TO N
           IF N <> -9876.1234
              DISPLAY "X1 '" X1 "' : " N.
           MOVE FUNCTION NUMVAL ( X2 ) TO N
           IF N <> -19876.1234
              DISPLAY "X2 '" X2 "' : " N
           ELSE IF N
            <> FUNCTION NUMVAL ( X2b )
           OR  N
            <> FUNCTION NUMVAL ( X2c )
           OR  N
            <> FUNCTION NUMVAL ( X2d )
              DISPLAY "NUMVAL not case-insensitive!".
           MOVE FUNCTION NUMVAL ( X3 ) TO N
           IF N <> -42.324
              DISPLAY "X3 '" X3 "' : " N.
           MOVE FUNCTION NUMVAL ( X4 ) TO N
           IF N <> 4232400
              DISPLAY "X4 '" X4 "' : " N.
           MOVE FUNCTION NUMVAL ( X5 ) TO N
           IF N <> .0043
              DISPLAY "X5 '" X5 "' : " N.

      *    Note: the following are "empty" tests
           MOVE FUNCTION NUMVAL ( EMPT ) TO N
           IF N <> 0
              DISPLAY "EMPT '" EMPT "' :  " N.
           MOVE FUNCTION NUMVAL ( VSIZED ) TO N
           IF N <> 0
              DISPLAY "VSIZED '" VSIZED "' :  " N.

      *    Note: the following tests with invalid data, pre 3.2
      *          return zero, 3.2+ get "whatever is valid there
      *          (which seem to be what MF is doing)
           MOVE FUNCTION NUMVAL ( BAD1 ) TO N
           IF N <> 0 AND N <> -1.045
              DISPLAY "BAD1 '" BAD1 "' : " N.
           MOVE FUNCTION NUMVAL ( BAD2 ) TO N
           IF N <> 0 AND N <> 10
              DISPLAY "BAD2 '" BAD2 "' : " N.
           STOP RUN.