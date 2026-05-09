IDENTIFICATION DIVISION.
       PROGRAM-ID.    CHECKBOOL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  VAR1                    PIC X(16) VALUE "#0001".
       01  VAR2                    PIC X(16) VALUE "#0002".
       01  VAR3                    PIC X(16) VALUE "#0003".
       01  VAR4                    PIC X(16) VALUE "#0004".
       PROCEDURE DIVISION.
       MAIN-PROGRAM SECTION.
       INIZIO.
           IF VAR1 = (VAR2 AND VAR3 AND VAR4)
              DISPLAY "TRUE 1"
           END-IF
           IF VAR1 NOT = (VAR2 AND VAR3 AND VAR4)
              DISPLAY "TRUE 2"
           END-IF
           IF VAR1 NOT > (VAR2 AND VAR3 AND VAR4)
              DISPLAY "TRUE 3"
           END-IF
           GOBACK.