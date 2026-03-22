IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  flag PIC X.
           88  blah VALUE "N".

       SCREEN           SECTION.
       01  scr.
           03  PIC X COLUMN blah TO blah FROM blah.

       PROCEDURE        DIVISION.
           ACCEPT scr
           .