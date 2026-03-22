IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
           SYSERR IS ERR-STREAM
           .
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  a-field      PIC XXX.

       SCREEN           SECTION.
       01  scr.
           03 VALUE "blah" LINE 5 COL 5.

       PROCEDURE        DIVISION.
           *> Valid statements
           DISPLAY "123" "456" "789" NO ADVANCING
           DISPLAY "foo" COL 1 HIGHLIGHT AT LINE 1 WITH UNDERLINE,
               "bar", "foo"
           DISPLAY "a" UPON CRT, "b" LINE 3 COL 3, "c" UPON CRT-UNDER
           DISPLAY scr, scr

           ACCEPT a-field LINE 5 SIZE 3 AT COL 1 WITH AUTO
               REVERSE-VIDEO, BLINK

           *> invalid statements
           DISPLAY scr WITH NO ADVANCING
           DISPLAY scr, scr LINE 2 COL 2 UPON ERR-STREAM
           DISPLAY "foo" LINE 2 COL 2, scr
           DISPLAY "foo" LINE 2 COL 2, "bar" UPON ERR-STREAM
           DISPLAY "foo" LINE 1 UPON ERR-STREAM
           DISPLAY scr, "foo"
           .
       END PROGRAM prog.

       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog-2.

       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
           CONSOLE IS CRT
           .
       PROCEDURE DIVISION.
           DISPLAY "foo" NO ADVANCING
           .
       END PROGRAM prog-2.