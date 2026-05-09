IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE '9876'.
       PROCEDURE        DIVISION.
           CALL 'callee' USING X.
           CALL 'callee' USING OMITTED.
           STOP RUN.