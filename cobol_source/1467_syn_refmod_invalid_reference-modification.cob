IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "abcd".
          88 X-AB       VALUE "AB".
       PROCEDURE        DIVISION.
           DISPLAY X-AB(1:1).
      *> TODO: more to add
           GOBACK.