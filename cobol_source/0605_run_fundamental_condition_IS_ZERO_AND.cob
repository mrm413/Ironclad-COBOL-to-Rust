IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  V            PIC 9 VALUE 0.
       01  W            PIC 9 VALUE 1.
       PROCEDURE        DIVISION.
           IF V IS ZERO
              DISPLAY "V IS ZERO"
           END-IF.
           IF V IS ZERO AND W EQUAL 1
              DISPLAY "V IS ZERO AND W EQUAL 1"
           END-IF.
           IF W EQUAL 1 AND V IS ZERO
              DISPLAY "W EQUAL 1 AND V IS ZERO"
           END-IF.
           IF W IS POSITIVE
              DISPLAY "W IS POSITIVE"
           END-IF.
           IF W IS NEGATIVE
              DISPLAY "W IS NEGATIVE"
           END-IF.
           IF W IS POSITIVE AND V EQUAL 0
              DISPLAY "W IS POSITIVE AND V EQUAL 0"
           END-IF.
           IF V EQUAL 0 AND W IS POSITIVE
              DISPLAY "V EQUAL 0 AND W IS POSITIVE"
           END-IF.