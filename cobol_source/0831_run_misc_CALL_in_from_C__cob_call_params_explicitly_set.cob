IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P1            PIC X.
       01 P2            PIC X(6).
       PROCEDURE        DIVISION USING P1 OPTIONAL P2.
           IF P2 NOT OMITTED
              DISPLAY 'UNEXPECTED P2: ' P2
           END-IF
           DISPLAY 'P1: ' P1 WITH NO ADVANCING
           EXIT PROGRAM.