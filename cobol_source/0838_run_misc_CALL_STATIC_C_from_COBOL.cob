IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 P1            PIC X VALUE "A".
       01 P2            PIC X(7).
       77 P2-COB        PIC X(7).
       PROCEDURE        DIVISION.
           CALL STATIC 'callee' USING P1 P2
           IF P1 NOT EQUAL "B"
              DISPLAY 'NOT A: ' P1
              END-DISPLAY
           END-IF
           UNSTRING P2 DELIMITED BY LOW-VALUE
              INTO P2-COB
           END-UNSTRING
           EVALUATE TRUE
              WHEN P2-COB NOT EQUAL "FROM C"
                 DISPLAY P2-COB '-' P2
                 END-DISPLAY
              WHEN RETURN-CODE NOT = 3
                 DISPLAY RETURN-CODE
                 END-DISPLAY
              WHEN OTHER
                 DISPLAY 'OK'  WITH NO ADVANCING
                 END-DISPLAY
                 MOVE 0  TO RETURN-CODE
           END-EVALUATE
           EXIT PROGRAM.