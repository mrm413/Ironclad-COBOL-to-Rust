IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 X             PIC 9.
       PROCEDURE        DIVISION.
           PERFORM VARYING X FROM 4
                   UNTIL   X > 6
             DISPLAY "X" NO ADVANCING
           END-PERFORM.
           IF X NOT = 7
             DISPLAY "WRONG X: " X
           END-IF
           STOP RUN.