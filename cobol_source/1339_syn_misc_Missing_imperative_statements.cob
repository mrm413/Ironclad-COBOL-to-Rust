IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  var       PIC X(200).
       01  othervar  PIC X(115).
       01  A         PIC 9 VALUE 1.
       01  B         PIC 9 VALUE 2.
       01  C         PIC 9 VALUE 3.
       78  var-len   value 115.

       PROCEDURE DIVISION.

           IF var-len < 16
           ELSE
               move othervar to var
           END-IF

           IF var-len > 16
           ELSE
               move othervar to var
           END-IF

           IF (2 = 3)
           ELSE
              IF 1 = 1
              ELSE
                 IF 1 = 1
                    move var to othervar
                 END-IF
              END-IF
           .

           EVALUATE TRUE
           WHEN  A = B
               move var      to othervar
           WHEN OTHER
           END-EVALUATE

           PERFORM WITH TEST BEFORE UNTIL 1 <> 3
           END-PERFORM

           EVALUATE FALSE
           WHEN  A = B
           WHEN  B = A
           END-EVALUATE.

           EVALUATE TRUE
           WHEN  A = B
               move var      to othervar
           WHEN OTHER
           .

           EVALUATE TRUE
           WHEN  A = B
           WHEN  B = A
           .

           STOP RUN.