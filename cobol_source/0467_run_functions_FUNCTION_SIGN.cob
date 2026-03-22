IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Z            USAGE BINARY-LONG SIGNED.
       01  F            USAGE FLOAT-LONG.
       PROCEDURE        DIVISION.
           MOVE FUNCTION SIGN ( 3.12345 ) TO Z.
           IF Z NOT = 1
              DISPLAY "Sign 1 " Z.
           MOVE FUNCTION SIGN ( -0.0 ) TO Z.
           IF Z NOT = 0
              DISPLAY "Sign 2 " Z.
           MOVE FUNCTION SIGN ( 0.0 ) TO Z.
           IF Z NOT = 0
              DISPLAY "Sign 3 " Z.
           MOVE FUNCTION SIGN ( -3.12345 ) TO Z.
           IF Z NOT = -1
              DISPLAY "Sign 4 " Z.
           MOVE 3.12345 TO F
           MOVE FUNCTION SIGN ( F ) TO Z.
           IF Z NOT = 1
              DISPLAY "Sign 5 " Z.
           MOVE -0.0 TO F
           MOVE FUNCTION SIGN ( F ) TO Z.
           IF Z NOT = 0
              DISPLAY "Sign 6 " Z.
           MOVE -3.12345 TO F
           MOVE FUNCTION SIGN ( F ) TO Z.
           IF Z NOT = -1
              DISPLAY "Sign 7 " Z.
           STOP RUN.