IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P1            PIC X.
       01 P2            PIC X(6).
       PROCEDURE        DIVISION USING P1 OPTIONAL P2.
           IF P2 NOT OMITTED
              DISPLAY P2
           END-IF
           EXIT PROGRAM.