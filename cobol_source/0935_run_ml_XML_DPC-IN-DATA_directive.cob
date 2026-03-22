$SET DPC-IN-DATA "JSON"
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
           
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  num PIC 9V9 VALUE 1,1.
       01  out PIC X(100).
       
       PROCEDURE DIVISION.
           XML GENERATE out FROM num
           IF out <> '<num>1.1</num>'
              DISPLAY "Failed: " FUNCTION TRIM (out).