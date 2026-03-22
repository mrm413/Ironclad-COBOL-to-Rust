IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4).
       01 Y             PIC 9 VALUE 1.
       PROCEDURE        DIVISION.
           DISPLAY X(0:1)
           END-DISPLAY.
           DISPLAY X(0:Y)
           END-DISPLAY.
           DISPLAY X(5:1)
           END-DISPLAY.
           DISPLAY X(5:Y)
           END-DISPLAY.
           DISPLAY X(1:0)
           END-DISPLAY.
           DISPLAY X(Y:0)
           END-DISPLAY.
           DISPLAY X(1:5)
           END-DISPLAY.
           DISPLAY X(Y:5)
           END-DISPLAY.
           STOP RUN.