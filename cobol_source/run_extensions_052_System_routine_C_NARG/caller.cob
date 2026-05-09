IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X VALUE "X".
       01  N            PIC 9 USAGE BINARY.
       LINKAGE SECTION.
       77  Y            PIC X.
       77  Z            PIC X.
       PROCEDURE        DIVISION.
           CALL "C$NARG" USING N
           END-CALL
           IF N NOT = 2
              DISPLAY "NOTOK caller (1) " N
              END-DISPLAY
           END-IF
           CALL "callee" USING X
           END-CALL
           CALL "C$NARG" USING N
           END-CALL
           IF N NOT = 2
              DISPLAY "NOTOK caller (2) " N
              END-DISPLAY
           END-IF
           STOP RUN.