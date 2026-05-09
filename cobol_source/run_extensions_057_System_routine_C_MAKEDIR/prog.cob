IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           CALL "C$MAKEDIR" USING "TMP"
           END-CALL.
           STOP RUN.