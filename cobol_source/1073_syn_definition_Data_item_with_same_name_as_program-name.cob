IDENTIFICATION  DIVISION.
       FUNCTION-ID.    x.
       DATA            DIVISION.
       LINKAGE         SECTION.
       01  ret         PIC 99.
       PROCEDURE       DIVISION RETURNING ret.
           CONTINUE
           .
       END FUNCTION x.


       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  x            PIC 999 VALUE 134.