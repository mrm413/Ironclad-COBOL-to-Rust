IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 Z  PIC X(10)  VALUE "d4b2e1a3c5".
       01 G             REDEFINES Z.
         02 TBL         OCCURS 10 ASCENDING KEY K INDEXED BY I.
           03 K         PIC X.
       01 KK            PIC X.
       PROCEDURE        DIVISION.
           SORT TBL ASCENDING KEY K.
           SET KK TO "3"
           SEARCH ALL TBL
              AT END
                 DISPLAY KK " NOT FOUND"
              WHEN K (I) = KK
                 CONTINUE
           END-SEARCH
      >>IF   EXPECT-ORDER  =  'ASCII'
           IF I NOT = 3
      >>ELIF EXPECT-ORDER  =  'EBCDIC'
           IF I NOT = 8
      >>END-IF
              DISPLAY "ERROR" END-DISPLAY
           STOP RUN.