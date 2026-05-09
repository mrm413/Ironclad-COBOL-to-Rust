IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 n pic 99 value 89.
       01 m pic 99 value 0.
       01 variable usage signed-int value 0.
          88 a-one value 1.
          88 a-two value 2.
       PROCEDURE DIVISION.
      *> bug #702, "pow"-call in generated program
           display n(n**0+ 1:) with no advancing.
           display "-"         with no advancing.
           display n(n**m+ 1:) with no advancing.
      *> bug #631 arithmetic handling (optimize code)
           if not a-one and not a-two
              display 'succeeded'
           else
              display 'failed'.
           GOBACK.