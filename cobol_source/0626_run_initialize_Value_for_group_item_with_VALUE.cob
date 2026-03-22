IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
      *01 FAILED        PIC 9(4) COMP-5 VALUE ZERO.
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
              DISPLAY "Compile failed: " G "."
              DISPLAY "     should be: "
                      "09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ."
      *       ADD 1 TO FAILED
           END-IF.
           INITIALIZE G.
           IF G NOT = "00 0 0 0 0  00 0 0 0 0  00 0 0 0 0  "
              DISPLAY "INITIALIZE failed: " G "."
              DISPLAY "        should be: "
                      "00 0 0 0 0  00 0 0 0 0  00 0 0 0 0  ."
      *       ADD 1 TO FAILED
           END-IF.
           INITIALIZE G ALL TO VALUE.
           IF G NOT = "09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ"
              DISPLAY "INIT VALUE failed: " G "."
              DISPLAY "        should be: "
                      "09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ09Y9Y9Y9Y9YZ."
      *       ADD 1 TO FAILED
           END-IF.
      *    IF FAILED = ZERO
      *       DISPLAY "All INITIALIZE tests passed."
      *    END-IF
           STOP RUN.