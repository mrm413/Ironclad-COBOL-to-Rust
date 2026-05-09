IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
       SCREEN  SECTION.
       01 SG.
          05 SI1   LINE 1 COL 1 PIC X FROM X.
          05 SI2   LINE 2 COL 1 PIC X FROM SPACE.
          05 SI2-2 LINE 2 COL 5 PIC X(03) FROM ALL SPACES.
          05 SI3   LINE 3 COL 1 PIC 9 FROM ZERO.
          05 SI3-2 LINE 3 COL 5 PIC X(03) FROM ALL ZEROES.
          05 SI4   LINE 4 COL 1 FROM X.  *> PIC is implied by FROM
       PROCEDURE        DIVISION.
           DISPLAY SG END-DISPLAY.
           STOP RUN.