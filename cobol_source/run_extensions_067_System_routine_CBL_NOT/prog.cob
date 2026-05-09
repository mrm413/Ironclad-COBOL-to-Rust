IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(4) VALUE HIGH-VALUE.
       PROCEDURE        DIVISION.
           CALL "CBL_NOT" USING X
                BY VALUE LENGTH OF X
           END-CALL.
           IF X NOT = LOW-VALUE
              DISPLAY "NG" NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.