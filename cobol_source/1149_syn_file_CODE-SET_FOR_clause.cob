IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           ALPHABET A IS EBCDIC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN "f.dat" LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  f CODE-SET A FOR x, y, z.
       01  x.
           03  y PIC X(10).
       01  x-2.
           03  z PIC X(10).