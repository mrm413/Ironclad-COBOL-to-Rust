IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  PROG         PIC X.

       PROCEDURE        DIVISION.
           CONTINUE
           .
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      foo COMMON.
       END PROGRAM      foo.

       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      barr.
       PROCEDURE        DIVISION.
           CONTINUE
           .
       *> This should cause an error (clashes with COMMON subprog foo)
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      foo.
       END PROGRAM      foo.
       END PROGRAM      barr.
       END PROGRAM      prog.


       *> This should cause an error.
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  foo          PIC X.

       PROCEDURE        DIVISION.
           CONTINUE
           .
       *> This should clash with the data definition.
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      foo.
       END PROGRAM      foo.
       END PROGRAM      prog.

       *> This should cause an error
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      samename.
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      samename.
       END PROGRAM      samename.
       END PROGRAM      samename.