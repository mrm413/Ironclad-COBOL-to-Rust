IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  tally PIC 999 VALUE 1.

       PROCEDURE DIVISION.
           ADD 1 TO tally
           DISPLAY tally UPON SYSOUT
           .