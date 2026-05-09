IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-SPACES      PIC XXX VALUE "    ".
       01 X-Xs          PIC XX  VALUE "XXX".
      *> not longer but goes into similar codegen:
       01 X-XXX         PIC XXX VALUE "XX".
       PROCEDURE        DIVISION.
           IF X-SPACES NOT = ALL SPACE
             DISPLAY 'BAD SPACE: ' X-SPACES.
           IF X-Xs NOT = ALL "X"
             DISPLAY 'BAD X: ' X-Xs.
           IF X-XXX NOT = "XX "
             DISPLAY 'BAD XXX: ' X-XXX.
           STOP RUN.