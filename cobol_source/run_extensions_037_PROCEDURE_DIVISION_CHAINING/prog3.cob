IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog3.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X.
       01  ABCD         PIC X(4).
       01  NUM          PIC 9 VALUE 7.
       PROCEDURE        DIVISION
                        CHAINING X ABCD NUM.
           IF X    NOT = "X"    OR
              ABCD NOT = "ABCD"
              DISPLAY "X = " X " ABCD = " ABCD
              END-DISPLAY
           END-IF
           IF NUM  NOT = 7
              DISPLAY "NUM not INITIALIZED: " NUM
              END-DISPLAY
           END-IF
           STOP RUN.