IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           DISPLAY FUNCTION FORMATTED-DATETIME
                       ("YYYYDDDThhmmssZ", 1, 1, 1, SYSTEM-OFFSET)
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-TIME
                       ("hhmmssZ", 1, 1, SYSTEM-OFFSET)
           END-DISPLAY
           .