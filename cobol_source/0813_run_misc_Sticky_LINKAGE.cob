IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P1            PIC X    VALUE "A".
       01 P2            PIC X(6) VALUE "NOT OK".
       PROCEDURE        DIVISION.
           CALL "callee" USING P1 P2.
           MOVE "B"      TO P1.
           MOVE "OKOKOK" TO P2.
           CALL "callee" USING P1.
           STOP RUN.