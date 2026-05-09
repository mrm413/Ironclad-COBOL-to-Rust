IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MYFLD        PIC 9(4) VALUE 96.
       01  BIGFLT       COMP-1 VALUE 543.12345E10.
       PROCEDURE        DIVISION.
       MAIN-1.
           DISPLAY "Initial value"
           PERFORM SHOW-IT.
           DISPLAY "MOVE BIGFLT"
           MOVE BIGFLT TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE SPACES"
           MOVE SPACES TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE LOW-VALUES"
           MOVE LOW-VALUES TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE HIGH-VALUES"
           MOVE HIGH-VALUES TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE QUOTE"
           MOVE QUOTE TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE ALL *"
           MOVE ALL '*' TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE ALL 0"
           MOVE ALL '0' TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE ALL 'A1'"
           MOVE ALL 'A1' TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE ALL '21'"
           MOVE ALL '21' TO MYFLD.
           PERFORM SHOW-IT.
           DISPLAY "MOVE HIGH-VALUES TO (1:)"
           MOVE HIGH-VALUES TO MYFLD (1:).
           PERFORM SHOW-IT.

           DISPLAY "MOVE HIGH-VALUES TO BIGFLT"
           MOVE HIGH-VALUES TO BIGFLT.
           PERFORM SHOW-BIG.
           CALL "dump" USING BIGFLT.
           DISPLAY "MOVE QUOTE TO BIGFLT"
           MOVE QUOTE TO BIGFLT.
           PERFORM SHOW-BIG.
           CALL "dump" USING BIGFLT.
           DISPLAY "MOVE ALL * TO BIGFLT"
           MOVE ALL '*' TO BIGFLT.
           PERFORM SHOW-BIG.
      *>   Note: the next results are dependant on endianess
      *>         therefore no dump here
           DISPLAY "MOVE ALL '21' TO BIGFLT"
           MOVE ALL '21' TO BIGFLT.
           PERFORM SHOW-BIG.
           STOP RUN.
       SHOW-IT.
           CALL "dump" USING MYFLD.
       SHOW-BIG.
           DISPLAY "BIGFLT is " BIGFLT.