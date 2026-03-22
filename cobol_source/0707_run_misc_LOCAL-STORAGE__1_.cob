IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 WRK-X         PIC XXX VALUE "abc".
       LOCAL-STORAGE    SECTION.
       01 LCL-X         PIC XXX VALUE "abc".
       PROCEDURE        DIVISION.
           DISPLAY WRK-X LCL-X NO ADVANCING
           END-DISPLAY.
           MOVE ZERO TO WRK-X LCL-X.
           EXIT PROGRAM.