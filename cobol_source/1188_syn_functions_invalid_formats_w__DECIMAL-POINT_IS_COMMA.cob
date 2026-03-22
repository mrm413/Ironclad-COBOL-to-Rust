IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       PROCEDURE        DIVISION.
           DISPLAY FUNCTION FORMATTED-TIME ("hhmmss,ss", 1).
           DISPLAY FUNCTION FORMATTED-DATETIME
                       ("YYYYMMDDThhmmss,ss", 1, 1).

           DISPLAY FUNCTION FORMATTED-TIME ("hhmmss.ss", 1).
           DISPLAY FUNCTION FORMATTED-DATETIME
                       ("YYYYMMDDThhmmss.ss", 1, 1).

           STOP RUN.