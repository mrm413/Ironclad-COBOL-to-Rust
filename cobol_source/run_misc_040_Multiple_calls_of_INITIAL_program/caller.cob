IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  PARAM1       PIC X(08).
       01  PARAM2       PIC 9999 COMP VALUE 08.
       PROCEDURE        DIVISION.
           MOVE ' PARAM 1' TO PARAM1
           PERFORM 10 TIMES
              CALL "callee" USING PARAM1 PARAM2 END-CALL
           END-PERFORM
           DISPLAY 'PARAM1 = ' PARAM1
           END-DISPLAY
           STOP RUN.