IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 G2          OCCURS 3.
           03 X         PIC 9.
           03 Y.
             04 Y-REC   OCCURS 5.
              05  Y1    PIC 9 VALUE 9.
              05  Y2    PIC X VALUE 'Y'.
           03 Z         PIC X VALUE 'Z'.
       PROCEDURE        DIVISION.
           MOVE ALL "A" TO G2(1)
           MOVE ALL "B" TO G2(2)
           MOVE ALL "C" TO G2(3)
           INITIALIZE Y (2).
           IF G NOT = "AAAAAAAAAAAAB0 0 0 0 0 BCCCCCCCCCCCC"
              DISPLAY "Test 1 failed: " G "."
              DISPLAY "    should be: "
                      "AAAAAAAAAAAAB0 0 0 0 0 BCCCCCCCCCCCC.".
           MOVE ALL "A" TO G2(1)
           MOVE ALL "B" TO G2(2)
           MOVE ALL "C" TO G2(3)
           MOVE 2       TO X(1)
           INITIALIZE Y (X(1)).
           IF G NOT = "2AAAAAAAAAAAB0 0 0 0 0 BCCCCCCCCCCCC"
              DISPLAY "Test 2 failed: " G "."
              DISPLAY "    should be: "
                      "2AAAAAAAAAAAB0 0 0 0 0 BCCCCCCCCCCCC.".
           STOP RUN.