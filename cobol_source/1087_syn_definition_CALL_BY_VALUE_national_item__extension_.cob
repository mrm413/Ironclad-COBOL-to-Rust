IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  N            PIC N(4).
       PROCEDURE        DIVISION.
           CALL "PROG2" USING BY VALUE N
           END-CALL.
           STOP RUN.