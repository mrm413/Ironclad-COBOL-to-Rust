IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(4) VALUE X"03030303".
       01  Z            PIC X(4) VALUE X"05050505".
       PROCEDURE        DIVISION.
           CALL "CBL_NOR" USING X Z
                BY VALUE LENGTH OF Z
           END-CALL.
           IF Z NOT = X"F8F8F8F8"
              DISPLAY "NG" NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.