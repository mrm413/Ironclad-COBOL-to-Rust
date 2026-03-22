IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           ALPHABET A-EBC IS EBCDIC
           ALPHABET A-ASC IS ASCII
           SYMBOLIC Z-EBC IS 241 IN A-EBC
           SYMBOLIC Z-ASC IS  49 IN A-ASC
           .
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Z            PIC X.
       PROCEDURE        DIVISION.
           MOVE Z-ASC   TO Z.
           IF Z NOT = "0"
              DISPLAY Z.
           MOVE Z-EBC   TO Z.
           IF Z NOT = "0"
              DISPLAY Z.
           STOP RUN.