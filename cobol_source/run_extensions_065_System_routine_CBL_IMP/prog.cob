IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(4) VALUE HIGH-VALUE.
       01  Z            PIC X(4) VALUE "1111".
       PROCEDURE        DIVISION.
           CALL "CBL_IMP" USING X Z
                BY VALUE LENGTH OF Z
           END-CALL.
           IF Z NOT = "1111"
              DISPLAY Z NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.