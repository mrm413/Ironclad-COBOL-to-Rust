IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G.
         02 X           PIC X OCCURS 4 TO 6 DEPENDING ON N.
       01 N             PIC 9 VALUE 4.
       PROCEDURE        DIVISION.
           EVALUATE TRUE
           WHEN N >= 5
            AND X(5) <> SPACE
              DISPLAY "1-" X(5)
           WHEN N >= 5
           WHEN X(5) <> SPACE
              DISPLAY "2-" X(5)
           END-EVALUATE
           STOP RUN.