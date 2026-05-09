IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(2) VALUE "ok".
       PROCEDURE        DIVISION.
           CALL "C$TOUPPER" USING X BY VALUE 2
           END-CALL.
           IF X NOT = "OK"
              DISPLAY X NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.