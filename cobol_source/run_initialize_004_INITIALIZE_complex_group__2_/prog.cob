IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 G2          OCCURS 2.
           03 X         PIC 9.
           03 Y         PIC X OCCURS 2.
           03 Z         PIC X.
       PROCEDURE        DIVISION.
           INITIALIZE G1.
           IF G1 NOT = "0   0   "
              DISPLAY "Test failed: " G1 "."
              DISPLAY "  should be: "
                      "0   0   .".
           STOP RUN.