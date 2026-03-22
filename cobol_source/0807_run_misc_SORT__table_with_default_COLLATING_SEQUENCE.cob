IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 Z  PIC X(10)  VALUE "d4b2e1a3c5".
       01 G             REDEFINES Z.
         02 TBL         OCCURS 10.
           03 X         PIC X.
       PROCEDURE        DIVISION.
           SORT TBL ASCENDING KEY X.
      >>IF   EXPECT-ORDER  =  'ASCII'
           IF G NOT = "12345abcde"
      >>ELIF EXPECT-ORDER  =  'EBCDIC'
           IF G NOT = "abcde12345"
      >>ELSE           *>  =  'NATIVE'
           IF NOT G = "12345abcde" OR "abcde12345"
      >>END-IF
              DISPLAY G END-DISPLAY
           END-IF.
           STOP RUN.