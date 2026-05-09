IDENTIFICATION   DIVISION.
       PROGRAM-ID.      wrong.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  X            PIC X.
       PROCEDURE        DIVISION.
           CALL "CBL_OR" USING X
           END-CALL
           STOP RUN.