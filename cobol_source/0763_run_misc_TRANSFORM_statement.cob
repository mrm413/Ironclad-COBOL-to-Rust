IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           ALPHABET MY-ASCII  IS STANDARD-1.
           ALPHABET MY-EBCDIC IS EBCDIC.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(3) VALUE "BCA".
       PROCEDURE        DIVISION.
      *> internally: "alias" to INSPECT CONVERTING
           TRANSFORM X FROM "ABC" TO "BCD".
           IF X NOT = "CDB"
              DISPLAY "X: " X.
      *> optional CHARACTERS and ALPHABETs (value test is separate)
           TRANSFORM X CHARACTERS FROM MY-ASCII TO MY-EBCDIC.
      *>
           STOP RUN.