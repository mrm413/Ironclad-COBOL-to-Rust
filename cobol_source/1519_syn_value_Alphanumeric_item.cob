IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-ABC         PIC XXX VALUE "abc".
       01 X-ABCD        PIC XXX VALUE "abcd".
       01 X-SPACE       PIC XXX VALUE "abc   ".
       01 X-123         PIC XXX VALUE 123.
       PROCEDURE        DIVISION.
           STOP RUN.