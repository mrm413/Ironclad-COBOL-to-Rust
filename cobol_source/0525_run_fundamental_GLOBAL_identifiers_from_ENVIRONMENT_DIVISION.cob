FUNCTION-ID. f1.
       DATA DIVISION.
       LINKAGE SECTION.
       01 r BINARY-LONG.
       PROCEDURE DIVISION RETURNING r.
           move 1 to r
           GOBACK
           .
       END FUNCTION f1.
       FUNCTION-ID. f2.
       DATA DIVISION.
       LINKAGE SECTION.
       01 i BINARY-LONG.
       01 r BINARY-LONG.
       PROCEDURE DIVISION USING i RETURNING r.
           add i to i giving r
           GOBACK
           .
       END FUNCTION f2.

       PROGRAM-ID.   prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION f1
           FUNCTION f2.
       SPECIAL-NAMES.
           CURRENCY SIGN IS "Y"
           DECIMAL-POINT IS COMMA.

       PROCEDURE DIVISION.
           CALL "prog-nested"
           .

       PROGRAM-ID. prog-nested.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  n1    BINARY-LONG VALUE 0.
       77  curr  PIC 9.9999,99Y.

       PROCEDURE DIVISION.
           MOVE f1()   TO n1
           IF n1 NOT = 1
             DISPLAY "ERROR 1" GOBACK
           END-IF
           MOVE f2(n1) TO n1
           IF n1 NOT = 2
             DISPLAY "ERROR 2" GOBACK
           END-IF
           MOVE f1()   TO n1
           IF n1 NOT = 1
             DISPLAY "ERROR 1 2nd" GOBACK
           END-IF
           MOVE f2(f2(n1)) TO n1
           IF n1 NOT = 4
             DISPLAY "ERROR 4" GOBACK
           END-IF
           MOVE n1 TO curr
           DISPLAY curr

           GOBACK
           .
       END PROGRAM prog-nested.
       END PROGRAM prog.