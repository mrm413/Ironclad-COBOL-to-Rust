IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  VAR.
           03  X            PIC X VALUE 'a'.
           03  ABCD         PIC X(4).
           03  NUM          PIC 9 VALUE 7.
       PROCEDURE        DIVISION
                        CHAINING VAR.
           DISPLAY '-' VAR '-' WITH NO ADVANCING
           END-DISPLAY
           STOP RUN.