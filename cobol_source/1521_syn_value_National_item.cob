IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 N-ABC         PIC NNN VALUE N"abc".
       01 N-ABCD        PIC NNN VALUE N"abcd".
       01 N-SPACE       PIC NNN VALUE N"abc   ".
       01 X-123         PIC NNN VALUE 123.
       01 X-ABC         PIC NNN VALUE "abc".
       PROCEDURE        DIVISION.
           STOP RUN.