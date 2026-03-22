IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  P            USAGE    POINTER.
       01  X            PIC      X(4) VALUE Z"ABC".
       01  TEST-FLD     USAGE    BINARY-LONG.
       PROCEDURE        DIVISION.
           MOVE FUNCTION CONTENT-LENGTH ( P )
             TO TEST-FLD.
           IF TEST-FLD NOT = 0
              DISPLAY 'CONTENT-LENGTH NULL wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
           SET P TO ADDRESS OF X
           MOVE FUNCTION CONTENT-LENGTH ( P )
             TO TEST-FLD
           IF TEST-FLD NOT = 3
              DISPLAY 'CONTENT-LENGTH z"abc" wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
           STOP RUN.