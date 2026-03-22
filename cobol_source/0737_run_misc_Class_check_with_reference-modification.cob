IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(6) VALUE "123   ".
       PROCEDURE        DIVISION.
           IF X(1:3) NUMERIC
              STOP RUN.
           DISPLAY "NG" NO ADVANCING.
           STOP RUN.