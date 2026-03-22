*> simple prototypes
       IDENTIFICATION DIVISION.
       PROGRAM-ID. recursion-test PROTOTYPE.
       DATA DIVISION.
       LINKAGE SECTION.
       01  n PIC 9.
       PROCEDURE DIVISION USING n.
       END PROGRAM recursion-test.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. cancel-test IS PROTOTYPE.
       PROCEDURE DIVISION.
       END PROGRAM cancel-test.

      *> program referencing those prototpyes
       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       REPOSITORY.
           PROGRAM recursion-test
           PROGRAM cancel-test
           .
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       77  prog-ptr    USAGE PROGRAM-POINTER VALUE NULL.
       01  num         PIC 9 VALUE 0.

       PROCEDURE       DIVISION.
           CALL recursion-test USING num
           DISPLAY "<"

           CALL cancel-test
           CALL cancel-test
           CANCEL cancel-test
           CALL cancel-test
           DISPLAY "<"
           SET prog-ptr TO ADDRESS OF PROGRAM recursion-test
           IF  prog-ptr = NULL
               DISPLAY 'address of recursion-prog not set' UPON SYSERR
           ELSE
               SET prog-ptr TO NULL
           END-IF
           SET prog-ptr TO ADDRESS OF PROGRAM cancel-test
           IF  prog-ptr = NULL
               DISPLAY 'address of cancel-prog not set' UPON SYSERR
           ELSE
               SET prog-ptr TO NULL
           END-IF
           .
       END PROGRAM     prog.

      *> actual implementation of the prototyped programs
       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     recursion-test RECURSIVE.

       DATA            DIVISION.
       LINKAGE         SECTION.
       01  x           PIC 9.

       PROCEDURE       DIVISION USING x.
           ADD 1 TO x
           DISPLAY x NO ADVANCING
           IF x = 1
      *>       CHECKME: Should this work (disabled for now...) ?
      *>       CALL recursion-test USING x
               CALL "recursion-test" USING x
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