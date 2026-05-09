IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-1           PIC 9(2)  VALUE B"010101".
       01 X-2           PIC 9(20) VALUE B"111111111111111111111111111111
      -                                  "111111111111111111111111111111
      -                                  "1111".
       PROCEDURE        DIVISION.
           DISPLAY X-1
           END-DISPLAY.
           DISPLAY X-2
           END-DISPLAY.
           STOP RUN.