IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "abcd".
       01 I             PIC 9 VALUE 3.
       PROCEDURE        DIVISION.
           IF X(3:I) <> SPACES
              DISPLAY X(3:I) NO ADVANCING.
           STOP RUN.