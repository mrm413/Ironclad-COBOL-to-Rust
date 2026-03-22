IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P1            PIC X.
       01 P2            PIC X(6).
       PROCEDURE        DIVISION USING P1 P2.
           IF P1 NOT EQUAL "A"
              DISPLAY P1.
           IF P2 NOT EQUAL "FROM C"
              DISPLAY P2
           ELSE
              DISPLAY "OK" WITH NO ADVANCING.
           EXIT PROGRAM.