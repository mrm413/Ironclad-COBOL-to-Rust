IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X           PIC X.
         02 G2          OCCURS 2.
           03 Y         PIC 9.
         02 Z           PIC 9.
       PROCEDURE        DIVISION.
           INITIALIZE G1.
           IF G1 NOT = " 000"
              DISPLAY "Test failed: " G1 "."
              DISPLAY "  should be: "
                      " 000.".
           STOP RUN.