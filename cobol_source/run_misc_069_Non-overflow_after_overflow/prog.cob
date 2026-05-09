IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC 9(2) VALUE 0.
       01  Y            PIC 9(2) VALUE 0.
       PROCEDURE        DIVISION.
           COMPUTE X = 100. *> this overflows which does not store a result
           COMPUTE Y = 99.  *> and once in a time this result was not stored
           IF X NOT = 0 AND
              Y NOT = 99
              DISPLAY Y.
           STOP RUN.