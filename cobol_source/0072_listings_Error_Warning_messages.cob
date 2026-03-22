IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 TEST-VAR PIC 9(2) VALUE 12.
       COPY 'prog.cpy'.
       PROCEDURE        DIVISION.
           DISPLAY TEST-VAR NO ADVANCING
           END-DISPLAY
           MOVE 'AA' TO TEST-VAR
           DISPLAY TEST-VAR NO ADVANCING
           END-DISPLAY
           STOP RUN.