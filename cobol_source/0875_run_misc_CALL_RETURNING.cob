IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 my-display-return   PIC 99.
       77 my-binary-return    USAGE BINARY-LONG.
       PROCEDURE        DIVISION.
           CALL "callee" RETURNING my-display-return
           END-CALL
           IF RETURN-CODE NOT = 0
              DISPLAY '1 - unexpected RETURN-CODE: ' RETURN-CODE.
           IF my-display-return NOT = 43
              DISPLAY '1- unexpected RETURNING: ' my-display-return.
      *>
           STOP RUN.