IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G-1.
         02 X           PIC X.
       01 G-2.
         02 Y           PIC X.
       PROCEDURE        DIVISION.
           MOVE CORR X TO G-1.
           MOVE CORR G-1 TO X.
           MOVE CORR G-1(1:1) TO G-2.
           MOVE CORR G-1 TO G-2(1:1).
           STOP RUN.