IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog3.
       DATA             DIVISION.
       SCREEN           SECTION.
       01 x-scr.
          03 x PIC X VALUE "a" OCCURS 10 COL  + 10.
       01 y-scr.
          03 y PIC X VALUE "a" OCCURS 10 LINE - 10.
       01 a-scr.
          03 a PIC X VALUE "a" OCCURS 10 COL  PLUS 10.
       01 b-scr.
          03 b PIC X VALUE "a" OCCURS 10 LINE MINUS 10.