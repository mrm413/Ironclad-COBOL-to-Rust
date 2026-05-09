identification division.
       program-id. prog.

       DATA DIVISION.
       WORKING-STORAGE  SECTION.

       01  W01-STRING    PIC X(20) VALUE '0123456789'.
       01  W01-INDEX     PIC 9(04) BINARY.

       PROCEDURE DIVISION.
      *>   
           MOVE 0  TO W01-INDEX.
           INSPECT W01-STRING 
                   TALLYING W01-INDEX FOR TRAILING SPACE.
           IF W01-INDEX NOT = 10
           THEN
               DISPLAY 'Bad Result for Inspect Trailing Case 1'
           END-IF. 
      *>
           INSPECT W01-STRING REPLACING TRAILING SPACE BY 'A'. 
           IF W01-STRING NOT = '0123456789AAAAAAAAAA' 
           THEN
               DISPLAY 'Bad Result for Inspect Trailing Case 2' 
           END-IF.
      *>
           MOVE 0  TO W01-INDEX.
           INSPECT W01-STRING 
                   TALLYING W01-INDEX FOR TRAILING SPACE  
                   REPLACING TRAILING 'A' BY 'B'.
      *>
           IF     W01-STRING NOT = '0123456789BBBBBBBBBB' 
           THEN
               DISPLAY 'Bad Result for Inspect Trailing Case 3' 
           END-IF.
      *>
           MOVE 0  TO W01-INDEX.
           MOVE SPACES TO W01-STRING.
           INSPECT W01-STRING
                   TALLYING W01-INDEX FOR TRAILING 'A'.
      *>
           IF W01-INDEX  NOT = 0
           THEN
               DISPLAY 'Bad Result for Inspect Trailing Case 4'
               W01-INDEX
           END-IF.
      *>           
           MOVE 0  TO W01-INDEX.
           MOVE SPACES TO W01-STRING.
           INSPECT W01-STRING
                   TALLYING W01-INDEX FOR TRAILING SPACES.
      *>
           IF W01-INDEX NOT = 20
           THEN
               DISPLAY 'Bad Result for Inspect Trailing Case 5'
               W01-INDEX
           END-IF.
      *>
           GOBACK.