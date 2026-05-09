IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN TO 'f' LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-rec PIC X.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
       DECLARATIVES.
       f-error SECTION.
           USE AFTER ERROR ON f.
           GOBACK
           .
       END DECLARATIVES.

           DISPLAY "VALID"
           END-DISPLAY.

       P01.
           GO TO P02.
           DISPLAY "INVALID"
           END-DISPLAY.
       P02.
           GO TO P03
           CONTINUE.  *> explicit no unreachable warning
       P03.
           GO TO P04
           CONTINUE AFTER 2 SECONDS.  *> that's one again
       P04.
           STOP RUN.