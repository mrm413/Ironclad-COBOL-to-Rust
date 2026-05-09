IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P1            PIC X(2) VALUE "OK".
       PROCEDURE        DIVISION.
           CALL "callee" USING P1
           END-CALL.
           IF P1 NOT = SPACE
              DISPLAY P1.
           STOP RUN.