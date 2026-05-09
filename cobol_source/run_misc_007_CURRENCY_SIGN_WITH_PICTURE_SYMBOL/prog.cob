PROGRAM-ID.   prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           *> note the space after EUR / before ct.
           CURRENCY SIGN IS "EUR "      WITH PICTURE SYMBOL "U",
           CURRENCY SIGN IS " ct (EUR)" WITH PICTURE SYMBOL "c",
           Currency Sign is "$US" with Picture Symbol "$".

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  EUROS    PIC U99v99.
       77  cents    PIC c9,999.
       77  DOLLARS  Pic $$,$$9.99.

       PROCEDURE DIVISION.
           MOVE 12.34 TO EUROS
           MULTIPLY euros BY 1000 GIVING cents.
           DISPLAY "#" EUROS "# equal #" cents '#'.
           Move 1500 to Invoice-Amount
           Display "Invoice amount #1 is " Invoice-Amount '.'.
           Move 12.34 to Invoice-Amount
           Display "Invoice amount #2 is " Invoice-Amount '.'.

           GOBACK
           .
       END PROGRAM prog.