IDENTIFICATION   DIVISION.
       PROGRAM-ID.      buggy.
       DATA             DIVISION.
       LOCAL-STORAGE    SECTION.
       77 VAR           PIC X.
       77 VPOS          PIC 9 VALUE 2.
       PROCEDURE        DIVISION.
           DISPLAY 'out of bounds - refmod following' WITH NO ADVANCING
           DISPLAY VAR (VPOS:)
           DISPLAY 'AFTER ERROR'
           GOBACK.