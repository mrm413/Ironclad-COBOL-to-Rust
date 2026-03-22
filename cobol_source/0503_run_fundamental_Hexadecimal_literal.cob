IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
       >>IF CHARSET = 'EBCDIC'
           DISPLAY X"F1F2F3"
       >>ELSE
           DISPLAY X"313233"
       >>END-IF
           END-DISPLAY.
           CALL "dump" USING X"000102"
           END-CALL.
           STOP RUN.