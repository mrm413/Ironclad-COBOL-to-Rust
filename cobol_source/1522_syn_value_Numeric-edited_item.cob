IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-SPACE       PIC **99.00  VALUE SPACE.
       01 X-123         PIC **999.00 VALUE 123.
       01 X-ABC         PIC **99.00  VALUE "abc".
       01 X-MATCH       PIC **99.00  VALUE "*123.00".
       01 X-OVERFLOW    PIC **99.00  VALUE "*123.000".
       PROCEDURE        DIVISION.
           MOVE     320.00 TO X-123
           STOP RUN.