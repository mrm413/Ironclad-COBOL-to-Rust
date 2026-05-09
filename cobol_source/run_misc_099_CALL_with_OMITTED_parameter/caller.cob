IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P1            PIC X    VALUE "A".
       PROCEDURE        DIVISION.
           CALL "callee" USING P1
           CALL "callee" USING P1 OMITTED
           STOP RUN.