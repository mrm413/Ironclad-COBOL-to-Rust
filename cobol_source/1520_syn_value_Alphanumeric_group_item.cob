IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G-1           VALUE 123.
         02 X           PIC XXX.
       01 G-2           VALUE "abc".
         02 X           PIC XXX.
       01 G-3           VALUE "abcd".
         02 X           PIC XXX.
       PROCEDURE        DIVISION.
           STOP RUN.