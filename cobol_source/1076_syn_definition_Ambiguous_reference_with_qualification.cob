IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X.
           03 Y         PIC X.
       01 G2.
         02 X.
           03 Y         PIC X.
       PROCEDURE        DIVISION.
           DISPLAY Y IN X.
           STOP RUN.