IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC XX VALUE "OK".
       PROCEDURE        DIVISION.
           CALL "prog2" USING BY VALUE X
           END-CALL.
           IF X NOT = "OK"
              DISPLAY X NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01  Y            PIC XX.
       PROCEDURE        DIVISION USING BY VALUE Y.
           MOVE "KO" TO Y.
           EXIT PROGRAM.
       END PROGRAM prog2.
       END PROGRAM prog.