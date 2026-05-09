IDENTIFICATION DIVISION.
       FUNCTION-ID. x AS "y".

       DATA DIVISION.
       LINKAGE SECTION.
       01  ret PIC 9(4).

       PROCEDURE DIVISION RETURNING ret.
           MOVE 100 TO ret
           .
       END FUNCTION x.

       IDENTIFICATION DIVISION.
       FUNCTION-ID. z.

       DATA DIVISION.
       LINKAGE SECTION.
       01  ret PIC 9(5).

       PROCEDURE DIVISION RETURNING ret.
           MOVE 1 TO ret
           .
       END FUNCTION z.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION y AS "y"
           FUNCTION z
           .
       PROCEDURE DIVISION.
           DISPLAY FUNCTION y
           DISPLAY FUNCTION z
           .
       END PROGRAM prog.