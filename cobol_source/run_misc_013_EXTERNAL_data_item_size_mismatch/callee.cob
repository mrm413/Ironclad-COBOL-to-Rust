IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 PRG-VAR       PIC X(8) EXTERNAL AS "WRK-VAR".
       01 COB-VAR       PIC X(8) EXTERNAL.
       01 EXT-VAR       PIC X(8) EXTERNAL.
       PROCEDURE        DIVISION.
           IF PRG-VAR NOT = "Extrn"
              DISPLAY 'local named external is not correct: ' PRG-VAR.
           IF COB-VAR NOT = "Hello"
              DISPLAY 'remote named external is not correct: ' COB-VAR.
           MOVE "World" TO EXT-VAR.
           EXIT PROGRAM.