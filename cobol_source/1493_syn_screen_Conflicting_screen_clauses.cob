IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  x            PIC 999.

       SCREEN           SECTION.
       01  scr.
           03  VALUE "foo" HIGHLIGHT, LOWLIGHT;
                           ERASE EOL, ERASE EOS;
                           BLANK LINE, BLANK SCREEN.

       PROCEDURE        DIVISION.
           DISPLAY "blah" WITH HIGHLIGHT, LOWLIGHT;
                               ERASE EOL, ERASE EOS;
                               BLANK LINE, BLANK SCREEN;
                               SCROLL UP, SCROLL DOWN;

           ACCEPT x WITH AUTO, TAB; SCROLL UP, SCROLL DOWN;
               UPDATE, NO UPDATE

           SET scr ATTRIBUTE HIGHLIGHT ON, LOWLIGHT OFF
           .