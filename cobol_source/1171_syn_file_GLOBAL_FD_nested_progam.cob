IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN "foo.dat"
               ORGANIZATION INDEXED
               RECORD KEY f-key.

       DATA DIVISION.
       FILE SECTION.
       FD  f                                   GLOBAL.
       01  f-rec                               GLOBAL.
           03  f-key                           PIC 9.

       PROCEDURE DIVISION.
           CALL "output-statement".

       IDENTIFICATION DIVISION.
       PROGRAM-ID. output-statement.

       PROCEDURE DIVISION.
           WRITE f-rec.
           END PROGRAM output-statement.
       END PROGRAM prog.