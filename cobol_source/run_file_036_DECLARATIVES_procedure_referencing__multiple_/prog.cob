IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN "./TEST-FILE".
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(10).
       WORKING-STORAGE  SECTION.
       01 Z             USAGE BINARY-LONG VALUE 0.
       PROCEDURE        DIVISION.
       DECLARATIVES.
       P01 SECTION.
           USE AFTER ERROR PROCEDURE ON TEST-FILE.
       P0101.
           ADD 1 TO Z.
       P02 SECTION.
           USE AFTER ERROR PROCEDURE ON OUTPUT.
       P0201.
           ADD 1 TO Z.
       END DECLARATIVES.
       MP01 SECTION.
       MP0101.
           OPEN  INPUT  TEST-FILE.
           PERFORM P01 THRU P02.
           IF Z NOT = 3
              DISPLAY Z.
           GOBACK.