IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X1     PIC   X(12) VALUE " -0.1234E+4 ".
       01  X2     PIC   X(12) VALUE " .1234e-2 ".
       01  BAD1   PIC   X(18) VALUE " -000E-12".
       01  N      PIC   s9(8)v9(10).
       PROCEDURE        DIVISION.
           MOVE FUNCTION NUMVAL-F ( X1 ) TO N
           IF N NOT = -1234
              DISPLAY "X1 '" X1 "' : " N.
           MOVE FUNCTION NUMVAL-F ( X2 ) TO N
           IF N NOT = .001234
              DISPLAY "X2 '" X2 "' : " N.

      *    Note: the following tests with invalid data, pre 3.2
      *          return zero, 3.2+ get "whatever is valid there
      *          (which seem to be what MF is doing)
           MOVE FUNCTION NUMVAL-F ( BAD1 ) TO N
           IF N <> 0
              DISPLAY "BAD1 '" BAD1 "' : " N.
           STOP RUN.