IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   S9V9(35).
       01  P   PIC   S9V9(35) PACKED-DECIMAL.
       01  S   PIC    9V9(35) COMP-6.
      *>01  N   PIC   S9V9(35) COMP-5.  big binary support pending
       PROCEDURE        DIVISION.
           MOVE FUNCTION ASIN ( -0.2345 ) TO Y.
           IF Y NOT = -0.23670419431334681587017874688345882
              DISPLAY "DISPLAY: " Y.
           MOVE FUNCTION ASIN ( -0.2345 ) TO P.
           IF P NOT = -0.23670419431334681587017874688345882
              DISPLAY "PACKED:  " P.
           MOVE FUNCTION ASIN ( -0.2345 ) TO S.
           IF S NOT = 0.23670419431334681587017874688345882
              DISPLAY "COMP-6:  " S.
      *>    MOVE FUNCTION ASIN ( -0.2345 ) TO N.
      *>    IF N NOT = -0.23670419431334681587017874688345882
      *>       DISPLAY "DISPLAY: " N.
      *>   cheating: we compare a huge internal field
      *>             (96 digits) here for the testsuite
           IF FUNCTION ASIN ( -00000.2345 ) NOT =
              FUNCTION ASIN ( -.234500000 )
              DISPLAY "ASIN IS NOT ITSELF".
           STOP RUN.