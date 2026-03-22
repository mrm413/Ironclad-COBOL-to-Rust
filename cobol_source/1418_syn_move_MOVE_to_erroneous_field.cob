IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 INVALID-ITEM.
       01 I             PIC 9(3).
       PROCEDURE        DIVISION.
           MOVE 1 TO INVALID-ITEM.
           MOVE SPACE TO I(1:2).
           STOP RUN.