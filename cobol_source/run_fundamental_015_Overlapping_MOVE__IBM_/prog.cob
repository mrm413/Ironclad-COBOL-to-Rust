IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  FILLER.
         05  TSTMOV1 PIC X(479).
         05  TSTMOV2 PIC X(10).
       PROCEDURE DIVISION.
           MOVE "0123456789" TO TSTMOV2.
           MOVE TSTMOV2 (2:9) TO TSTMOV2 (1:9)
           IF TSTMOV2 NOT = "1234567899"
              DISPLAY "  PROBLEM MOVE: " TSTMOV2
           ELSE
              DISPLAY "  OK with MOVE: " TSTMOV2.
           MOVE "0123456789" TO TSTMOV2.
           MOVE TSTMOV2 (1:8) TO TSTMOV2 (2:8)
           IF TSTMOV2 = "0000000009"
              DISPLAY "IBM style MOVE: " TSTMOV2
           ELSE IF TSTMOV2 NOT = "0012345679"
              DISPLAY "  PROBLEM MOVE: " TSTMOV2
           ELSE
              DISPLAY "  OK with MOVE: " TSTMOV2.
           STOP RUN.