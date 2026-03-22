IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
           SELECT TEST-FILE ASSIGN "NOTEXIST"
           FILE STATUS IS TEST-STATUS.
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE.
       01  TEST-REC      PIC X(4).
       WORKING-STORAGE SECTION.
       01  TEST-STATUS  PIC XX.
       PROCEDURE        DIVISION.
       A00-MAIN SECTION.
       A00.
           DISPLAY FUNCTION EXCEPTION-LOCATION '|'
                   NO ADVANCING
           END-DISPLAY.
           OPEN INPUT TEST-FILE.
           PERFORM B00-MAIN.

       B00-MAIN SECTION.
       B00.
           DISPLAY FUNCTION EXCEPTION-LOCATION
                   NO ADVANCING
           END-DISPLAY.
           STOP RUN.