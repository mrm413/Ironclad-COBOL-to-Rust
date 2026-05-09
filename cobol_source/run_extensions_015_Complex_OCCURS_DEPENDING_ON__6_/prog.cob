IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  n            PIC 9 VALUE 2.
       01  m            PIC 9 VALUE 3.

       01  a-table      VALUE "ABCDEFGHIJ".
           03  rows     OCCURS 0 TO 2 TIMES
                        DEPENDING ON n.
                05  chars OCCURS 0 TO 5 TIMES
                          DEPENDING ON m
                          PIC X.

       01  vals         PIC X(3).

       PROCEDURE DIVISION.
           MOVE chars (1, 2) TO vals (1:1)
           MOVE chars (2, 1) TO vals (2:1)
           MOVE chars (2, 3) TO vals (3:1)
           IF vals NOT = "BDF"
              DISPLAY "Vals (slided) wrong: " vals
              END-DISPLAY
           END-IF
           IF a-table NOT = "ABCDEF"
              DISPLAY "Table (slided) wrong: " a-table
              END-DISPLAY
           END-IF
           .