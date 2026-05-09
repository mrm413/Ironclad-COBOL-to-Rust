IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-1           PIC 9(9) VALUE 4660 COMP.
       01 X-2           PIC 9(9) VALUE 4660 COMP-5.
       PROCEDURE        DIVISION.
           CALL "dump" USING X-1 BY CONTENT 1
           END-CALL.
           CALL "dump" USING X-2 BY CONTENT 2
           END-CALL.
           STOP RUN.