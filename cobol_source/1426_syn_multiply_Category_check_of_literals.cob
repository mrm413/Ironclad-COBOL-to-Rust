IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC 9.
       PROCEDURE        DIVISION.
           MULTIPLY 123  BY X
           END-MULTIPLY.
           MULTIPLY "a"  BY X
           END-MULTIPLY.
           MULTIPLY 123  BY 456 GIVING X
           END-MULTIPLY.
           MULTIPLY "a"  BY "b" GIVING X
           END-MULTIPLY.
           STOP RUN.