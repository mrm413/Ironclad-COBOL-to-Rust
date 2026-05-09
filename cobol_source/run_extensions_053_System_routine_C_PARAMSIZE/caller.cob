IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC XX VALUE "XY".
       PROCEDURE        DIVISION.
           CALL "callee" USING X
           END-CALL.
           STOP RUN.