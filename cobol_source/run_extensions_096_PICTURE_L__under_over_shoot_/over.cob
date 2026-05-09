IDENTIFICATION   DIVISION.
       PROGRAM-ID.      over.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       1 X              PICTURE LX(5) DEPENDING ON LGX.
       1 LGX            PIC 9 VALUE 9.
       PROCEDURE        DIVISION.
       MAIN.
           DISPLAY X
           STOP RUN
           .