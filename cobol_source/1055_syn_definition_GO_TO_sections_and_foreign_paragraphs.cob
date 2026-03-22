IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
       S-1 SECTION.
           GO TO S-2.
       E-1.
           IF FUNCTION SECONDS-PAST-MIDNIGHT = 10
              GO TO S-1.  *> check that go to its own section is not warned

       S-2 SECTION.
           GO TO E-3.
       E-2.

       S-3 SECTION.
       E-3.