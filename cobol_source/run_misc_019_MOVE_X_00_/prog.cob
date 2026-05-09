IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC XXX.
       PROCEDURE        DIVISION.
           MOVE X"000102" TO X.
           CALL "dump" USING X
           END-CALL.
           STOP RUN.