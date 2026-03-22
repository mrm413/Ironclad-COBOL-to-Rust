IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "abcd".
       01 I             PIC 9 VALUE 0.
       PROCEDURE        DIVISION.
       >> REF-MOD-ZERO-LENGTH
           DISPLAY X(1:I) NO ADVANCING.
       >> REF-MOD-ZERO-LENGTH OFF
           DISPLAY X(1:I) NO ADVANCING.
           STOP RUN.