IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  some-const CONSTANT AS '123'.
       77  x          PIC XX.
       SCREEN SECTION.
       01  bild.
           05 from-constant-with-size   FROM some-const.
           05 from-constant-without-pic FROM ZERO.
           05 LINE 24 COL 1 FROM message.
           05 from-func-without-pic     FROM FUNCTION TRIM(x).
           05 from-func-with-pic        FROM FUNCTION TRIM(x) PIC XX.