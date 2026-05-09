IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(4) VALUE " OK ".
       PROCEDURE        DIVISION.
           CALL "C$JUSTIFY" USING X "L"
           END-CALL.
           IF X NOT = "OK  "
              DISPLAY X NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.