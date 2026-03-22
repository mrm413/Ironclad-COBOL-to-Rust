IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-123         PIC BXX VALUE 123.
       01 X-ABC         PIC BXX VALUE "abc".
       01 X-MATCH       PIC BXX VALUE " ab".
       01 X-OVERFLOW    PIC BXX VALUE " abc".
       PROCEDURE        DIVISION.
           STOP RUN.