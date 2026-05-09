IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE
              ASSIGN    GLOB-PATH
       .
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST-FILE    GLOBAL.
       01  TEST-REC     PIC X(4).
       WORKING-STORAGE  SECTION.
       78  GLOB-PATH           GLOBAL VALUE "GLOBP1".
       01  GLOB-PATH2 CONSTANT GLOBAL       "GLOBP2".
      * Test global vars because of implicitly defined ASSIGN var, too.
       78  GLOB-VAR            GLOBAL VALUE "GLOBV1".
       01  GLOB-VAR2  CONSTANT GLOBAL       "GLOBV2".
       PROCEDURE        DIVISION.
           DISPLAY GLOB-PATH GLOB-VAR
           END-DISPLAY.
           CALL "prog2"
           END-CALL.
           CALL "prog3"
           END-CALL.
           STOP RUN.
        IDENTIFICATION   DIVISION.
        PROGRAM-ID.      prog2.
        ENVIRONMENT      DIVISION.
        INPUT-OUTPUT     SECTION.
        FILE-CONTROL.
        SELECT TEST2-FILE
               ASSIGN    GLOB-PATH2
        .
        DATA             DIVISION.
        FILE             SECTION.
        FD  TEST2-FILE   GLOBAL.
        01  TEST2-REC    PIC X(4).
        WORKING-STORAGE  SECTION.
        PROCEDURE        DIVISION.
            DISPLAY GLOB-PATH2 GLOB-VAR2
            END-DISPLAY.
            EXIT PROGRAM.
        END PROGRAM prog2.
       END PROGRAM prog.
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog3.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST3-FILE
              ASSIGN    GLOB-PATH
       .
       DATA             DIVISION.
       FILE             SECTION.
       FD  TEST3-FILE   GLOBAL.
       01  TEST3-REC    PIC X(4).
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           DISPLAY 'in prog3'
           END-DISPLAY
           IF GLOB-PATH NOT = SPACES
              DISPLAY GLOB-PATH
              END-DISPLAY
           END-IF
           EXIT PROGRAM.
       END PROGRAM prog3.