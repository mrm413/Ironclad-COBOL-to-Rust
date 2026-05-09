IDENTIFICATION  DIVISION.
       PROGRAM-ID.     caller.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       77  INT         IS TYPEDEF BINARY-LONG.
       77  EXT-INT     IS TYPEDEF BINARY-LONG EXTERNAL.
      *> should this be possible?
      *>77  INT-VAL     IS TYPEDEF USAGE INT VALUE 12.
       77  INT-VAL     IS TYPEDEF BINARY-LONG VALUE 12.
       77  SOMEVAR     USAGE INT VALUE 10.
       77  SOMEVAL     USAGE INT-VAL.
       77  SOMEEXT     USAGE EXT-INT.

       PROCEDURE       DIVISION.
           IF SOMEVAR <> 10
              DISPLAY "SOMEVAR (INT) wrong: " SOMEVAR
           END-IF
           IF SOMEVAL <> 12
              DISPLAY "SOMEVAR (INT-VAL) wrong: " SOMEVAL
           END-IF
           MOVE 42 TO SOMEEXT
           CALL "callee"
           .