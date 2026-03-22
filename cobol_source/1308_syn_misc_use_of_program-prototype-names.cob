IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       REPOSITORY.
           PROGRAM test-prog
           .
       PROCEDURE       DIVISION.
           CALL test-prog
           CANCEL test-prog
           .