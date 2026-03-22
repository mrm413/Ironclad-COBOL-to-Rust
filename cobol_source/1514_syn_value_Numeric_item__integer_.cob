IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-SPACE       PIC 999 VALUE SPACE.
       01 X-ABC         PIC 999 VALUE "abc".
       01 X-12-3        PIC 999 VALUE 12.3.
       01 X-123         PIC 999 VALUE 123.
       01 X-1234        PIC 999 VALUE 1234.
       PROCEDURE        DIVISION.
           STOP RUN.