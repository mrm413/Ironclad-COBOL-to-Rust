IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X           OCCURS 2.
           03 Y         PIC X OCCURS 3.
       PROCEDURE        DIVISION.
           DISPLAY X
           END-DISPLAY.
           DISPLAY X(1)
           END-DISPLAY.
           DISPLAY X(1, 2)
           END-DISPLAY.
           DISPLAY Y(1)
           END-DISPLAY.
           DISPLAY Y(1, 2)
           END-DISPLAY.
           DISPLAY Y(1, 2, 3)
           END-DISPLAY.
           STOP RUN.