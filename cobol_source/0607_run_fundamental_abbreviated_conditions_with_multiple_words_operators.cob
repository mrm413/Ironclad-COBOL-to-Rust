IDENTIFICATION DIVISION.
       PROGRAM-ID.    CHECKCOND.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  VAR1                    PIC X.
                88 VAR1-K VALUE 'K'
       01  VAR2                    PIC X.
                88 VAR2-K VALUE 'K'

       PROCEDURE DIVISION.
       MAIN-PROGRAM SECTION.
       BUG.
           IF VAR1-K AND NOT = VAR2-K
              DISPLAY "INVALID" UPON STDERR.
           GOBACK.