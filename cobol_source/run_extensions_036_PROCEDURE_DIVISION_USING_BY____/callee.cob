IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 X             PIC X.
       01 Y             PIC 99.
       01 Z             PIC 99 USAGE COMP.
       PROCEDURE        DIVISION
           USING BY VALUE X BY REFERENCE Y Z.
           MOVE "Z" TO X.
           MOVE 56 TO Y.
           MOVE 78 TO Z.
           EXIT PROGRAM.