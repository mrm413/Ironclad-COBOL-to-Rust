IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       PROCEDURE        DIVISION.
           CALL "hello" USING "COBOL"
           END-CALL.
           CALL "bye" USING "COBOL-ENTRY"
           END-CALL.
           STOP RUN.