IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P1            PIC X.
       01 P2            PIC X(6).
       01 P3            PIC X(6).
       PROCEDURE        DIVISION USING P1 P2.
           IF P1 = "A"
              SET ADDRESS OF P3 TO ADDRESS OF P2
           ELSE
              IF P3 NOT = "OKOKOK"
                 DISPLAY P3.
           EXIT PROGRAM.