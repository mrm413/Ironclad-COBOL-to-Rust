IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X.
           03  X1       PIC X.
           03  X234     PIC XXX.
       PROCEDURE        DIVISION.
           MOVE LOW-VALUE TO X1.
           MOVE "BCD"     TO X234.
           CALL "C$PRINTABLE" USING X
           END-CALL.
           IF X NOT = ".BCD"
              DISPLAY X NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.