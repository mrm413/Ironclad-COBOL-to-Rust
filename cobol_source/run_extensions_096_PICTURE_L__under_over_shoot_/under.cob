IDENTIFICATION   DIVISION.
       PROGRAM-ID.      under.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       1 X              PICTURE LX(9) DEPENDING ON LGX.
       1 LGX            PIC 9 VALUE 9.
       PROCEDURE        DIVISION.
       MAIN.
           MOVE 0 TO LGX
           DISPLAY X
           STOP RUN
           .