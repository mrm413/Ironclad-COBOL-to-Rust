IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 STR           PIC X(05).
       PROCEDURE        DIVISION.
           MOVE "OK" & " "
            & "OK"
             TO STR
           DISPLAY STR NO ADVANCING
           END-DISPLAY
           STOP RUN.