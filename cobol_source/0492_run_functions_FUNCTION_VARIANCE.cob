IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Z            PIC S9(4)V9(8).
       PROCEDURE        DIVISION.
           MOVE FUNCTION VARIANCE ( 3 -14 0 8 -3 ) TO Z.
           IF Z NOT = 54.16
              DISPLAY 'EXP 54.16 GOT ' Z.
      *>   COMPUTE has maximum possible intermediate
      *>   results via GMP - and thefore a different
      *>   set of function calls to set Z - this one
      *>   here is used for "huge decimal number from
      *>   display"
           COMPUTE Z = FUNCTION VARIANCE(4, 0, 5).
           IF Z NOT = 4.66666666
              DISPLAY 'EXP 4.66666666 GOT ' Z.
           STOP RUN.