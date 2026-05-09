IDENTIFICATION   DIVISION.
       PROGRAM-ID.      error.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 WRK-VAR       PIC X(5) EXTERNAL.
       01 MYVAR         PIC X(5) EXTERNAL AS "COB-VAR".
       01 EXT-VAR       PIC X(5) EXTERNAL.
       PROCEDURE        DIVISION.
           MOVE "Extrn" TO WRK-VAR
           MOVE "Hello" TO MYVAR
           MOVE SPACES  TO EXT-VAR
           CALL "callee"
           IF EXT-VAR NOT = "World"
              DISPLAY 'simple external back not correct: ' EXT-VAR.
           STOP RUN.