IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(2) VALUE "OK".
       PROCEDURE        DIVISION.
           CALL "C$TOLOWER" USING X BY VALUE 2
           END-CALL.
           IF X NOT = "ok"
              DISPLAY X NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.