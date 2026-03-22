IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
      *> explicit DISPLAY to verify size
           DISPLAY FUNCTION TEST-DATE-YYYYMMDD (20020231)
                   WITH NO ADVANCING.
           STOP RUN.