IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 G2          OCCURS 3.
           03 X         PIC 9 VALUE ZERO.
           03 Y.
             04 Y-REC   OCCURS 5.
              05  Y1    PIC 9 VALUE 9.
              05  Y2    PIC X VALUE 'Y'.
           03 Z         PIC X VALUE 'Z'.
       PROCEDURE        DIVISION.
           IF G NOT = "09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ"
              DISPLAY "Test failed: " G "."
              DISPLAY "  should be: "
                      "09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ.".
           STOP RUN.