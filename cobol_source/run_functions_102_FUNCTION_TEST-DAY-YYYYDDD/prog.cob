IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
      *> explicit DISPLAY to verify size
           DISPLAY FUNCTION TEST-DAY-YYYYDDD (2002400)
                   WITH NO ADVANCING.
           STOP RUN.