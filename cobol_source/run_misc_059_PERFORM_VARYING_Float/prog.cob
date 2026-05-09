IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  i USAGE FLOAT-LONG.

       PROCEDURE DIVISION.
           PERFORM VARYING i FROM 1.0 BY 1.0 UNTIL i > 5.0
                 DISPLAY i " " NO ADVANCING
           END-PERFORM .
           DISPLAY "Test Part 1 Completed".
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > 5
                 DISPLAY i " " NO ADVANCING
           END-PERFORM .
           DISPLAY "Test Part 2 Completed".
           PERFORM VARYING i FROM 5 BY -1 UNTIL i < 1
                 DISPLAY i " " NO ADVANCING
           END-PERFORM .
           DISPLAY "Test Part 3 Completed".
           STOP RUN.
           END PROGRAM prog.