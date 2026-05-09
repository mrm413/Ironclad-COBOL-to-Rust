IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  VAR       PIC X(200).
       01  OTHERVAR  PIC X(115).
       78  VAR-LEN   VALUE 115.

       PROCEDURE DIVISION.
       MAIN-10.
           MOVE "Peek a boo" TO VAR.
           EVALUATE TRUE
               ALSO FALSE
               ALSO TRUE
            WHEN    TRUE
               ALSO VAR-LEN > 16 AND VAR-LEN < 200
               ALSO TRUE
                  MOVE OTHERVAR (1 : VAR-LEN - 9)
                    TO VAR (16 - VAR-LEN : VAR-LEN - 9)
                  DISPLAY "A: Should NOT be executed"
            WHEN  TRUE
               ALSO VAR-LEN < 16
               ALSO TRUE
                  MOVE OTHERVAR TO VAR
                  DISPLAY "A: OK VAR-LEN > 16 AND VAR-LEN < 200"
            WHEN  TRUE
               ALSO VAR = SPACES
               ALSO TRUE
                  MOVE OTHERVAR TO VAR
                  DISPLAY "A: OK VAR IS SPACES"
           END-EVALUATE.

           MOVE "Peek a boo" TO VAR.
           EVALUATE 3 EQUALS 7
           WHEN  VAR = SPACES
               DISPLAY "B: OK VAR IS NOT SPACES"
           WHEN  VAR NOT = SPACES
               DISPLAY "B: FALSE VAR IS SPACES"
           END-EVALUATE.

           MOVE SPACES       TO VAR.
           EVALUATE FALSE
           WHEN  VAR = SPACES
               DISPLAY "C: FALSE VAR IS SPACES"
           WHEN  VAR NOT = SPACES
               DISPLAY "C: OK VAR IS SPACES"
           END-EVALUATE.

           MOVE "Peek a boo" TO VAR.
           EVALUATE TRUE
           WHEN  VAR = SPACES
               DISPLAY "D: BAD VAR IS SPACES"
           WHEN  VAR NOT = SPACES
               DISPLAY "D: OK VAR IS NOT SPACES"
           END-EVALUATE.

           MOVE SPACES       TO VAR.
           EVALUATE VAR-LEN ALSO VAR
           WHEN  < 32 ALSO SPACES
               DISPLAY "E: OK VAR IS SPACES"
           WHEN  > 16 ALSO NOT SPACES
               DISPLAY "E: BAD VAR IS NOT SPACES"
           WHEN OTHER
               DISPLAY "E: OK OTHER option taken"
           END-EVALUATE.

           STOP RUN.