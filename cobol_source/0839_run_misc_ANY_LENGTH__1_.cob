IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P2            PIC 99.
       LINKAGE          SECTION.
       01 P1            PIC X ANY LENGTH.
       PROCEDURE        DIVISION USING P1.
           MOVE LENGTH OF P1 TO P2.
           IF P2 NOT = 6
              DISPLAY P2.
           IF P1 NOT = "OKOKOK"
              DISPLAY P1.
           EXIT PROGRAM.