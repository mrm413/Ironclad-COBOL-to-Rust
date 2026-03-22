IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
       A00-MAIN SECTION.
       A00.
           DISPLAY FUNCTION EXCEPTION-LOCATION '|'
                   NO ADVANCING
           END-DISPLAY.
           CALL "sub".
           CANCEL "sub".
           PERFORM B00-MAIN.

       B00-MAIN SECTION.
       B00.
           DISPLAY FUNCTION EXCEPTION-LOCATION
                   NO ADVANCING
           END-DISPLAY.
           STOP RUN.