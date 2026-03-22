IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MYFLD        PIC 9(4) VALUE 96.
       01  BIGFLT       COMP-1 VALUE 543.12345E10.
       PROCEDURE        DIVISION.
       MAIN-1.
           MOVE BIGFLT TO MYFLD.
           MOVE SPACES TO MYFLD.
           MOVE LOW-VALUES TO MYFLD.
           MOVE HIGH-VALUES TO MYFLD.
           MOVE QUOTE TO MYFLD.
           MOVE ALL '*' TO MYFLD.
           MOVE ALL '0' TO MYFLD.
           MOVE ALL 'A1' TO MYFLD.
           MOVE ALL '21' TO MYFLD.
           SET MYFLD TO HIGH-VALUES.
           SET MYFLD TO SPACES.
           MOVE HIGH-VALUES TO MYFLD (1:).

           MOVE HIGH-VALUES TO BIGFLT.
           MOVE QUOTE TO BIGFLT.
           MOVE ALL '*' TO BIGFLT.
           MOVE ALL '21' TO BIGFLT.
           STOP RUN.