IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-X           PIC X.
       01 X-9           PIC 9.
       01 X-09          PIC 09.
       PROCEDURE        DIVISION.
           MULTIPLY 123  BY 456  GIVING 789
           MULTIPLY "a"  BY "b"  GIVING "c"
           MULTIPLY 123  BY 456  GIVING "c"
           MULTIPLY X-X  BY X-9  GIVING X-09
           MULTIPLY X-9  BY X-09 GIVING X-X
           MULTIPLY 123  BY 456  GIVING X-X
           MULTIPLY X-09 BY X-X  GIVING X-9
           STOP RUN.