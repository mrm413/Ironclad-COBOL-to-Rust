IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
       01 Y             PIC 99.
       01 Z             PIC 99 USAGE COMP.
       PROCEDURE        DIVISION.
           MOVE "X" TO X.
           MOVE 12 TO Y.
           MOVE 34 TO Z.
           CALL "callee" USING BY CONTENT X
                               BY REFERENCE Y
                               BY CONTENT Z
           END-CALL.
           IF X NOT = "X" OR
              Y NOT = 56  OR
              Z NOT = 34
                DISPLAY "X = " X " Y = " Y " Z = " Z
                END-DISPLAY
           END-IF
           STOP RUN.