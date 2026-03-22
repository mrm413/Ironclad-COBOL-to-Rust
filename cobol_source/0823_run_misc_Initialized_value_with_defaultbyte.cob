IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MYFLD        PIC X(6).
       PROCEDURE        DIVISION.
       ASTART SECTION.
       A01.
           IF MYFLD NOT = "AAAAAA"
              DISPLAY MYFLD
           END-IF
           STOP RUN.