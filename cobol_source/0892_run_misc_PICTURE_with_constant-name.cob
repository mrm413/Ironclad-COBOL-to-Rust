IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  foo-bar     CONSTANT 8.
       01  x           PIC 9(foo-bar)9(foo-bar).

       PROCEDURE DIVISION.
           IF FUNCTION LENGTH (x) <> 16
               DISPLAY FUNCTION LENGTH (x)
           END-IF
           .
       END PROGRAM prog.