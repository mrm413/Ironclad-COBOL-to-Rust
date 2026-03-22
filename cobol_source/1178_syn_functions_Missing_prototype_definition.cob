IDENTIFICATION DIVISION.
       FUNCTION-ID. blah.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION x
           PROGRAM y
           .
       DATA DIVISION.
       LINKAGE SECTION.
       01  ret PIC X.
           
       PROCEDURE DIVISION RETURNING ret.
           MOVE FUNCTION x TO ret
           MOVE FUNCTION x TO ret
           .
       END FUNCTION blah.