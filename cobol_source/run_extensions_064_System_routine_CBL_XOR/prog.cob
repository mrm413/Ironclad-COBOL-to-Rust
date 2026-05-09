IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(4) VALUE "3333".
       01  Z            PIC X(4) VALUE X"02020202".
       PROCEDURE        DIVISION.
           CALL "CBL_XOR" USING X Z
                BY VALUE LENGTH OF Z
           END-CALL.
           IF Z NOT = "1111"
              DISPLAY Z NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.