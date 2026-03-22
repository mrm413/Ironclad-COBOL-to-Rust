IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
      >>IF   EXPECT-ORDER  =  'ASCII'
           IF "1" NOT < "a"
      >>ELIF EXPECT-ORDER  =  'EBCDIC'
           IF "a" NOT < "1"
      >>END-IF
              DISPLAY "ERROR" END-DISPLAY
           END-IF.
           STOP RUN.