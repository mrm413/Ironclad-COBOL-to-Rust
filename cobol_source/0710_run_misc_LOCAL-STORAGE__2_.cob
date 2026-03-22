IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LOCAL-STORAGE    SECTION.
       01 LCL-X.
          05 FILLER     PIC XXX VALUE "abc".
       PROCEDURE        DIVISION.
           CALL "callee2" USING LCL-X.
           MOVE ZERO TO LCL-X.
           CALL "callee2" USING LCL-X.
           EXIT PROGRAM.