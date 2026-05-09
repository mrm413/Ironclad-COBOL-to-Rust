IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  VAR          PIC 9(01) value 1.
       PROCEDURE        DIVISION.
           DISPLAY VAR NO ADVANCING.
           ADD  1 TO VAR.
           GOBACK.