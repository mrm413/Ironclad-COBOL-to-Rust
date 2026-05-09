IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  N            PIC 9 USAGE BINARY.
       LINKAGE SECTION.
       77  X            PIC X.
       77  Y            PIC X.
       77  Z            PIC X.
       PROCEDURE        DIVISION.
           CALL "C$NARG" USING N
           END-CALL
           DISPLAY N WITH NO ADVANCING
           END-DISPLAY
           STOP RUN.