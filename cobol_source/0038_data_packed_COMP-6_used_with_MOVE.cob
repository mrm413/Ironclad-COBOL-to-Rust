IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-99          PIC 99   USAGE COMP-6.
       01 X-999         PIC 999  USAGE COMP-6.
       01 B-99          USAGE BINARY-LONG.
       01 B-999         USAGE BINARY-LONG.
       PROCEDURE        DIVISION.
           MOVE     0 TO B-99
           MOVE  B-99 TO X-99
           IF  X-99 NOT =   0 DISPLAY  "00 <" X-99  ">".
           MOVE    99 TO B-99
           MOVE  B-99 TO X-99
           IF  X-99 NOT =  99 DISPLAY  "99 <" X-99  ">".
           MOVE    0  TO B-999
           MOVE B-999 TO X-999
           IF X-999 NOT =   0 DISPLAY "000 <" X-999 ">".
           MOVE  123  TO B-999
           MOVE B-999 TO X-999
           IF X-999 NOT = 123 DISPLAY "123 <" X-999 ">".
           MOVE B-999 TO X-99
           IF  X-99 NOT =  23 DISPLAY  "23 <" X-99  ">".
           STOP RUN.