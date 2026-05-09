IDENTIFICATION   DIVISION.
       PROGRAM-ID.      hello.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 MSG-HELLO     PIC X(7) VALUE "Hello, ".
       01 MSG-BYE       PIC X(5) VALUE "Bye, ".
       LINKAGE          SECTION.
       01 X             PIC X(5).
       01 Y             PIC X(11).
       PROCEDURE        DIVISION USING X.
           DISPLAY MSG-HELLO X "!".
      * verifies that this does not generate an exception
       ENTRY "unused" USING Y.
           EXIT PROGRAM.

       ENTRY "bye" USING Y.
           DISPLAY MSG-BYE Y "!".
           EXIT PROGRAM.