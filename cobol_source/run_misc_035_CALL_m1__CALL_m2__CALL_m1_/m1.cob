IDENTIFICATION   DIVISION.
       PROGRAM-ID.      m1.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC 9(4).
       PROCEDURE        DIVISION.
           COMPUTE X = 1 + 2
           END-COMPUTE.
           IF X NOT = 3
              DISPLAY X.