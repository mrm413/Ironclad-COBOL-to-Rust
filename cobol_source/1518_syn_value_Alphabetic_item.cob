IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-123         PIC AAA VALUE 123.
       01 X-ZERO        PIC AAA VALUE ZERO.
       01 X-AB1         PIC AAA VALUE "ab1".
       01 X-ABC         PIC AAA VALUE "abc".
       01 X-ABCD        PIC AAA VALUE "abcd".
       PROCEDURE        DIVISION.
           STOP RUN.