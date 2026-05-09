IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  prgm        PIC X(32) VALUE "recursion-test".

       PROCEDURE       DIVISION.
           CALL prgm
           DISPLAY "<"

           MOVE "cancel-test" TO prgm
           CALL prgm
           CALL prgm
           CANCEL prgm
           CALL prgm
           DISPLAY "<"

           MOVE "dummy-call" TO prgm
           CALL prgm
       >> IF CHECK-PERF IS DEFINED
           PERFORM 500000 TIMES
              CALL prgm
           END-PERFORM
       >> END-IF
           .
       END PROGRAM     prog.


       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     recursion-test RECURSIVE.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  x           PIC 9 VALUE 0.

       PROCEDURE       DIVISION.
           ADD 1 TO x
           DISPLAY x NO ADVANCING
           IF x = 1
               CALL "recursion-test"
           END-IF
           .
       END PROGRAM     recursion-test.


       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     cancel-test.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  x           PIC 9 VALUE 1.

       PROCEDURE       DIVISION.
           DISPLAY x NO ADVANCING
           ADD 1 TO x
           .
       END PROGRAM     cancel-test.


       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     dummy-call.

       PROCEDURE       DIVISION.
           CONTINUE
           .
       END PROGRAM     dummy-call.