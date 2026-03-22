IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
         88 A           VALUE "A".
         88 B           REDEFINES A VALUE "B".
       PROCEDURE        DIVISION.
           STOP RUN.