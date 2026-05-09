IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  N            PIC 9 USAGE BINARY.
       77  X            PIC X.
       PROCEDURE        DIVISION.
           CALL "C$NARG" USING N X
           END-CALL
           IF N NOT = 2
              DISPLAY "NOTOK " N
              END-DISPLAY
           END-IF
           STOP RUN.