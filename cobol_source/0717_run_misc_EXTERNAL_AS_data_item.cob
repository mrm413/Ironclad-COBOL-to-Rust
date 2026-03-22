IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 PRG-VAR       PIC X(5) EXTERNAL AS "WRK-VAR".
       01 EXT-VAR       PIC X(5) EXTERNAL.
       PROCEDURE        DIVISION.
           IF PRG-VAR NOT = "Extrn"
              DISPLAY PRG-VAR.
           IF EXT-VAR NOT = "Hello"
              DISPLAY EXT-VAR.
           MOVE "World" TO EXT-VAR.
           EXIT PROGRAM.