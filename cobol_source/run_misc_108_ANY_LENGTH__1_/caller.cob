IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P1            PIC X(6) VALUE "OKOKOK".
       PROCEDURE        DIVISION.
           CALL "callee" USING P1
           END-CALL.
           STOP RUN.