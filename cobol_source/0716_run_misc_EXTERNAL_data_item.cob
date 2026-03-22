IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 EXT-VAR       PIC X(5) EXTERNAL.
       PROCEDURE        DIVISION.
           MOVE "Hello" TO EXT-VAR.
           CALL "callee"
           END-CALL.
           IF EXT-VAR NOT = "World"
              DISPLAY EXT-VAR.
           STOP RUN.