IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x PIC X.
       01  num PIC 9.

       SCREEN SECTION.
       01  scr.
           03  no-clauses.
           03  no-required-clauses BACKGROUND-COLOR 1.
           03  only-line LINE 1.
           03  numeric-pic-and-value PIC 999 VALUE 100.
           03  only-pic PIC 9.
           03  from-to-using-without-pic FROM x.
           03  auto-without-from-to-using PIC 9 AUTO.
           03  full-without-to-using PIC X FROM x FULL.
           03  full-and-justified PIC X USING x, FULL, JUST.
           03  secure-with-from PIC X FROM x SECURE.
           03  secure-justified-no-clauses VALUE "Hello" SECURE, JUST.
           03  blank-when-zero-without-pic FROM num, BLANK ZERO.
           03  justified-without-pic FROM x, JUST.
           03  sign-no-clauses PIC S9, SIGN LEADING SEPARATE.
           03  figurative-constant-value VALUE SPACES.
           03  only-erase ERASE EOL.
           03  only-blank BLANK SCREEN.
           03  only-bell BELL.
           03  numeric-value-no-pic VALUE 1.

       01 always-ok-scr.
           03  my-group LINE 1, COL 1, FULL.
               05  PIC X FROM "x" TO x.
               05  PIC Z USING num.
               05  VALUE "Hello, world!".