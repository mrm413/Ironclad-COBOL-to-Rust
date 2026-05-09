IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 L1 OCCURS 1000 TIMES.
           05 L2 PIC S9(9) COMP-5 VALUE 5.
           05 L3 PIC S9(9)        VALUE 5.
       01 INIT OCCURS 3 PIC X(256) VALUE SPACES.
       PROCEDURE DIVISION.
           IF L2(3) not = 5
              DISPLAY '0 VALUE(3) = ' L2(3).

           INITIALIZE L1(1).
           IF L2(1) not = 0
              DISPLAY '1 VALUE(1) = ' L2(1).
           IF L2(3) not = 5
              DISPLAY '1 VALUE(3) = ' L2(3).

           INITIALIZE L1(1)  DEFAULT.
           IF L2(1) not = 0
              DISPLAY '2 VALUE(1) = ' L2(1).
           IF L2(3) not = 5
              DISPLAY '2 VALUE(3) = ' L2(3).

           INITIALIZE L1(1)  ALL VALUE.
           IF L2(1) not = 5
              DISPLAY '3 VALUE(1) = ' L2(1).
           IF L2(3) not = 5
              DISPLAY '3 VALUE(3) = ' L2(3).

           IF INIT(1) NOT = SPACES 
              DISPLAY "INIT1 NOT = SPACES".
           IF INIT(3) NOT = SPACES 
              DISPLAY "INIT3 NOT = SPACES".

           MOVE ALL '*' TO INIT(1) INIT(2) INIT(3)
           IF INIT(2) (50:5) NOT = "*****"
              DISPLAY "INIT2 BADVAL".
           INITIALIZE INIT(2)  ALL TO VALUE.
           IF INIT(2) NOT = SPACES 
              DISPLAY "INIT2 NOT = SPACES".

           GOBACK.