IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(4).
       PROCEDURE        DIVISION.
           CALL "PROG2" USING BY VALUE X
           END-CALL.
           STOP RUN.