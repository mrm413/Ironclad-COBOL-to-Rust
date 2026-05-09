IDENTIFICATION   DIVISION.
       PROGRAM-ID.      m2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC 9(4).
       PROCEDURE        DIVISION.
           COMPUTE X = 3 + 4
           END-COMPUTE.
           IF X NOT = 7
              DISPLAY X.