IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P1            PIC X.
       01 RC            PIC 99.
       01 P2            PIC X(6).
       PROCEDURE        DIVISION USING P1 RC OPTIONAL P2.
           IF P2 NOT OMITTED
              DISPLAY 'UNEXPECTED P2: ' P2.
           DISPLAY 'P1: ' P1 WITH NO ADVANCING
           GOBACK RETURNING RC.