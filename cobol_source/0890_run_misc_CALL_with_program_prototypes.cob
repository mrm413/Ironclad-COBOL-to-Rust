IDENTIFICATION DIVISION.
       PROGRAM-ID. caller.

       PROCEDURE DIVISION.
       MAIN-LINE.

           PERFORM DO-CHECK
       >> IF CHECK-PERF IS DEFINED
      *>   minimal side-test for performance comparisons
           PERFORM DO-CHECK 10000 TIMES
       >> END-IF
           DISPLAY 'DONE' UPON SYSERR WITH NO ADVANCING
           GOBACK.

       DO-CHECK.
           CALL "prog"
           .