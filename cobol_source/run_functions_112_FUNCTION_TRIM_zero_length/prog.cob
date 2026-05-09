IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X   PIC   X(4) VALUE "NOOK".
       PROCEDURE        DIVISION.
           MOVE FUNCTION TRIM ( "  " ) TO X.
           DISPLAY ">" X "<"
           END-DISPLAY.
           DISPLAY ">" FUNCTION TRIM ( "   " ) "<"
           END-DISPLAY.
           STOP RUN.