IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  num PIC 999.

       SCREEN SECTION.
       01  scr.
           03  full-pointless PIC 999 TO num FULL.
           03  full-useful PIC ZZZ TO num FULL.