IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P2            PIC XXX.
       LINKAGE          SECTION.
       01 P1            PIC X ANY LENGTH.
       PROCEDURE        DIVISION USING P1.
           MOVE P1 TO P2.
           IF P2 NOT = "OK "
              DISPLAY P2.
           MOVE SPACE TO P1.
           EXIT PROGRAM.