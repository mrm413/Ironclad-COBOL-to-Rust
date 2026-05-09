IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callrec IS RECURSIVE.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 filler        PIC 9 VALUE 0.
          88 first-call VALUE 0.
          88 called     VALUE 1.
       PROCEDURE        DIVISION.
       SOME-SEC SECTION.
           IF first-call
              SET called TO TRUE
              CALL 'callrec'
           END-IF
           GOBACK.