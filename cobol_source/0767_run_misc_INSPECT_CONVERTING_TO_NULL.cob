IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(3) VALUE "AAA".
       PROCEDURE        DIVISION.
           INSPECT X CONVERTING "A" TO NULL
           IF X NOT = LOW-VALUES
              DISPLAY "NG".
           STOP RUN.