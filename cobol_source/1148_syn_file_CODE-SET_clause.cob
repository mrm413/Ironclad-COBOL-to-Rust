IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           ALPHABET A IS ASCII, ALPHABET EBC IS EBCDIC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f, ASSIGN "f.dat", LINE SEQUENTIAL.
           SELECT g, ASSIGN "g.dat", SEQUENTIAL.
           SELECT h, ASSIGN "h.dat", LINE SEQUENTIAL.
           SELECT i, ASSIGN "i.dat", SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
       FD  f CODE-SET A.
       01  f-rec PIC X(10).

       FD  g CODE-SET foo.
       01  g-rec PIC X(10).

       FD  h CODE-SET ebcdic.
       01  h-rec PIC X(10).

       FD  i CODE-SET ebc FOR h-rec.
       01  i-rec PIC X(10).