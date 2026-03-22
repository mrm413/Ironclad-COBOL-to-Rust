IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 MYVAR         PIC X(5) EXTERNAL AS "EXT-VAR".
       01 WRK-VAR       PIC X(5) EXTERNAL.
       PROCEDURE        DIVISION.
           MOVE "Extrn" TO WRK-VAR.
           MOVE "Hello" TO MYVAR.
           CALL "callee"
           END-CALL.
           IF MYVAR NOT = "World"
              DISPLAY MYVAR.
           STOP RUN.