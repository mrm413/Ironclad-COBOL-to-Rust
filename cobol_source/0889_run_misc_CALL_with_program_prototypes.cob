IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       PROCEDURE DIVISION.
           CALL "c"
           .
       END PROGRAM prog.


       IDENTIFICATION DIVISION.
       PROGRAM-ID. a AS "blah?Sdk".

       PROCEDURE DIVISION.
           DISPLAY "Hello!"
           .
       END PROGRAM a.


       IDENTIFICATION DIVISION.
       PROGRAM-ID. b.

       PROCEDURE DIVISION.
           DISPLAY "Hello again!"
           .
       END PROGRAM b.


       IDENTIFICATION DIVISION.
       PROGRAM-ID. c.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           PROGRAM d AS "blah?Sdk"
           PROGRAM b
           .

       PROCEDURE DIVISION.
           CALL d
           CALL b
           .
       END PROGRAM c.