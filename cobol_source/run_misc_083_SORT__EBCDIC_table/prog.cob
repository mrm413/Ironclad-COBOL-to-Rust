IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           ALPHABET ALPHA IS EBCDIC.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 Z  PIC X(10)  VALUE "d4b2e1a3c5".
       01 G.
         02 TBL         OCCURS 10.
           03 X         PIC X.
       PROCEDURE        DIVISION.
           MOVE Z TO G.
      *    alphabet-name as collation:
           SORT TBL ASCENDING KEY X SEQUENCE ALPHA.
           IF G NOT = "abcde12345"
              DISPLAY G.
           MOVE Z TO G.
      *    code-name as collation:
           SORT TBL DESCENDING KEY X SEQUENCE EBCDIC.
           IF G NOT = "54321edcba"
              DISPLAY G.
           STOP RUN.