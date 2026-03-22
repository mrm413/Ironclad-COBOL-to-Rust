IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(04) VALUE SPACES.
       PROCEDURE        DIVISION.
           MOVE 0 TO X.
           DISPLAY X NO ADVANCING END-DISPLAY.
           MOVE 1000 TO X.
           DISPLAY X NO ADVANCING END-DISPLAY.
           STOP RUN.