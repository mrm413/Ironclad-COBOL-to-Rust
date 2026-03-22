IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       ENVIRONMENT     DIVISION.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       77  prog-ptr    USAGE PROGRAM-POINTER.
       77  num         PIC 9 VALUE 0.

       PROCEDURE       DIVISION.
           SET  prog-ptr TO ADDRESS OF PROGRAM "recursion-test"
           CALL prog-ptr USING num
           DISPLAY "<"

           SET  prog-ptr TO ADDRESS OF PROGRAM "cancel-test"
           CALL prog-ptr
           CALL prog-ptr
           CANCEL "cancel-test"
      *>   NOTE: the following results in the previous address
      *>         if physical cancel is not active, otherwise _likely_
      *>         in a different one
           SET  prog-ptr TO ADDRESS OF PROGRAM "cancel-test"
           CALL prog-ptr
           DISPLAY "<"

           SET  prog-ptr TO ADDRESS OF PROGRAM "dummy-call"
           CALL prog-ptr
       >> IF CHECK-PERF IS DEFINED
           PERFORM 500000 TIMES
              CALL prog-ptr
           END-PERFORM
       >> END-IF
           .
       END PROGRAM     prog.


       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     recursion-test RECURSIVE.

       DATA            DIVISION.
       LINKAGE         SECTION.
       01  x           PIC 9.

       PROCEDURE       DIVISION USING x.
           ADD 1 TO x
           DISPLAY x NO ADVANCING
           IF x = 1
               CALL "recursion-test" USING x
           END-IF
           .
       END PROGRAM     recursion-test.


       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     cancel-test.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       77  self-ptr    USAGE PROGRAM-POINTER VALUE NULL.
       01  x           PIC 9 VALUE 1.

       PROCEDURE       DIVISION.
           SET self-ptr TO ENTRY "cancel-test"
           IF  self-ptr = NULL
               DISPLAY 'self-address not set' UPON SYSERR.
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