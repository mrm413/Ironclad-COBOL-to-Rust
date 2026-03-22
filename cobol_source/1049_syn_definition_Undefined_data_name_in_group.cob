IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X.
       01 Y             PIC X.
       PROCEDURE        DIVISION.
           DISPLAY Y IN G.
           STOP RUN.