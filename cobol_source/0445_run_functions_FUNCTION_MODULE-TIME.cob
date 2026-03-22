IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       DATA             DIVISION.
       WORKING-STORAGE SECTION.
       01  TEST-TIME    PIC 9(6) VALUE 0.
       PROCEDURE        DIVISION.
           MOVE FUNCTION MODULE-TIME TO TEST-TIME.
           IF   TEST-TIME NOT = 0
             DISPLAY "OK" NO ADVANCING
             END-DISPLAY
           END-IF.
           STOP RUN.