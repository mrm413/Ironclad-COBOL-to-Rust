IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       78 VAR-LEN       VALUE 4.
       01 X             PIC X(VAR-LEN).
       PROCEDURE        DIVISION.
           IF VAR-LEN < 4
              DISPLAY X(4 - VAR-LEN:1)
              DISPLAY X(1: 4 - VAR-LEN)
              DISPLAY X(9 - VAR-LEN:1)
              DISPLAY X(1:9 - VAR-LEN)
      *>      special test...
              INSPECT X CONVERTING "DEF"  TO X (1:0 + VAR-LEN)
           END-IF
           STOP RUN.