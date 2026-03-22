IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "abcd".
       01 I             PIC 9 VALUE 0.
       PROCEDURE        DIVISION.
           DISPLAY X(I:1) NO ADVANCING
           END-DISPLAY.
           STOP RUN.