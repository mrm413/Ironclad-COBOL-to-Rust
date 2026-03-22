#       IDENTIFICATION   DIVISION.
#       PROGRAM-ID.      prog3.
#       DATA             DIVISION.
#       WORKING-STORAGE  SECTION.
#       77 NUM           PIC 9 COMP-5 VALUE 3.
#       77 NUM2          PIC 9 COMP-5 VALUE 5.
#       01 G.
#         02 G2          OCCURS 0 TO 3 DEPENDING ON NUM.
#           03 X         PIC 9.
#           03 Y         PIC X VALUE 'Z'.
#           03 Z         OCCURS 1 TO 6 DEPENDING ON NUM2.
#              05  Z1    PIC 9 VALUE 9.
#              05  Z2    PIC X.
#       PROCEDURE        DIVISION.
#           MOVE ALL "A" TO G2(1)
#           MOVE ALL "B" TO G2(2)
#           MOVE ALL "C" TO G2(3)
#           INITIALIZE Y (2).
#           IF G NOT = "AAAAAAAAAAAAB0 0 0 0 0 BCCCCCCCCCCCC"
#              DISPLAY "Test 1 failed: " G ".".
#           MOVE ALL "A" TO G2(1)
#           MOVE ALL "B" TO G2(2)
#           MOVE ALL "C" TO G2(3)
#           MOVE 2       TO X(1)
#           INITIALIZE Y (X(1)).
#           IF G NOT = "2AAAAAAAAAAAB0 0 0 0 0 BCCCCCCCCCCCC"
#              DISPLAY "Test 2 failed: " G ".".
#           STOP RUN.
#