IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 EXT-VAR       PIC X(5) EXTERNAL.
       PROCEDURE        DIVISION.
           IF EXT-VAR NOT = "Hello"
              DISPLAY EXT-VAR.
           MOVE "World" TO EXT-VAR.
           EXIT PROGRAM.