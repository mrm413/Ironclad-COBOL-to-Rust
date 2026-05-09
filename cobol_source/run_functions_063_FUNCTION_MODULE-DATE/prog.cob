IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       DATA             DIVISION.
       WORKING-STORAGE SECTION.
       01  TEST-DATE    PIC 9(8) VALUE 0.
       PROCEDURE        DIVISION.
           MOVE FUNCTION MODULE-DATE TO TEST-DATE.
           IF   TEST-DATE NOT = 0
             DISPLAY "OK" NO ADVANCING
             END-DISPLAY
           END-IF.
           STOP RUN.