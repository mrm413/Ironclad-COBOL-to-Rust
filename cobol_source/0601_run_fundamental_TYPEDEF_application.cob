IDENTIFICATION  DIVISION.
       PROGRAM-ID.     callee.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       77  EXT-INT     IS TYPEDEF BINARY-LONG EXTERNAL.
       77  SOMEEXT     USAGE EXT-INT.

       PROCEDURE       DIVISION.
           IF SOMEEXT <> 42
              DISPLAY "SOMEEXT (EXT-INT) wrong: " SOMEEXT
           END-IF
           .