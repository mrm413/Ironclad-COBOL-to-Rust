IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 var1          pic x.
       $DISPLAY  MF compile time text # A.0-B;C *> without comment
       01 var2          pic x.
       >> DISPLAY some.text-here
       01 var3          pic x.
       PROCEDURE        DIVISION.
       >> DISPLAY   other  text #2  *> comment
       >> DISPLAY  "literal text...  *> no comment"
       $DISPLAY  "MF compile time text"
           GOBACK.