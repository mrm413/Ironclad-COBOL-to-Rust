IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT    IS COMMA.
       PROCEDURE        DIVISION.
           DISPLAY  12,3.
           DISPLAY +12,3.
           DISPLAY -12,3.
           DISPLAY 1,23E0.
           DISPLAY +1,23E0.
           DISPLAY -1,23E0.
           STOP RUN.