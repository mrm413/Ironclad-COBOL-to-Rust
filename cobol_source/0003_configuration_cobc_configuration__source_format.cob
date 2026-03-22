*Example prog in fixed format (the default)
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      fixed.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
      /
       PROCEDURE        DIVISION.
      D    DISPLAY 'START'
           DISPLAY '     20        30        40         50       60    '
           DISPLAY '     20        30        40         50       60     
      -            '    70'
      D    DISPLAY 'STOP'
           STOP RUN.