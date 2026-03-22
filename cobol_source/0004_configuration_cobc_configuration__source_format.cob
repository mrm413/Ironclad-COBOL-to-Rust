*Example prog in fixed format with wider record length
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      wide.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
      /
       PROCEDURE        DIVISION.
           DISPLAY '     20        30        40         50       60         70 '
           DISPLAY '     20        30        40         50       60         70
      -            '        80'
           STOP RUN.