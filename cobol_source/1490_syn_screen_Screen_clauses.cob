IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  foo          PIC X.
       SCREEN           SECTION.
       01  scr.
           03  a        PIC X TO foo FULL, REQUIRED,
                        LEFTLINE, RIGHTLINE, OVERLINE, UNDERLINE,
                        GRID.
       PROCEDURE        DIVISION.
           STOP RUN.