IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 W             PIC X.
       01 X             PIC X.
       01 Y             PIC X.
       01 Z             PIC X.
       PROCEDURE        DIVISION.
           CALL "callee".
           CALL "callee" USING W.
           CALL "callee" USING W X.
           CALL "callee" USING W X Y.
           CALL "callee" USING W X Y OMITTED.
           CALL "callee" USING W X Y Z.
           STOP RUN.