[
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(11).
       01 T             PIC 9.
       01 S             USAGE COMP-1 VALUE ZERO.
       PROCEDURE        DIVISION.
           MOVE 1 TO T
           MOVE ""135,151,151"bar"195,194,234"" TO X
           IF X NOT EQUAL "foobarBAZ" PERFORM SHOW.

           MOVE 2 TO T
           MOVE "  "135,151,151"bar"195 194"Z" TO X
           IF X NOT EQUAL "  foobarBAZ" PERFORM SHOW.

           MOVE 3 TO T
           MOVE ' '135 151,151'bar'195,194'Z' TO X
           IF X NOT EQUAL " foobarBAZ" PERFORM SHOW.

           MOVE 4 TO T
           MOVE ""75,80,91"" TO X
           IF X NOT EQUAL "[!]" PERFORM SHOW.

           STOP RUN S.
       SHOW.
           DISPLAY "EBCDIC LIT " T " FAILED: X = """ X """"
           MOVE 1 TO S.
]