IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X   PIC      S9(4)V9(4) VALUE -1.5.
       01  N   PIC      N(9).
       01  TEST-FLD     PIC S9(04)V9(02).
       01  TEST-TAB.
           05 T-ENTRIES   PIC 99 VALUE 10.
           05 TEST-ENTRY  PIC X OCCURS 1 TO 10 DEPENDING ON T-ENTRIES.
       PROCEDURE        DIVISION.
           MOVE FUNCTION LENGTH ( X )
             TO TEST-FLD
           IF TEST-FLD NOT = 8
              DISPLAY 'LENGTH "00128" wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
           MOVE FUNCTION LENGTH ( N )
             TO TEST-FLD
           IF TEST-FLD NOT = 9
              DISPLAY 'LENGTH N(9) wrong: ' TEST-FLD
              END-DISPLAY
           END-IF

           MOVE FUNCTION LENGTH ( '00128' )
             TO TEST-FLD
           IF TEST-FLD NOT = 5
              DISPLAY 'LENGTH "00128" wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
      *    note: we currently do not support items of category boolean...
      *>   MOVE FUNCTION LENGTH ( b'100' )
      *>     TO TEST-FLD
      *>   IF TEST-FLD NOT = 3
      *>      DISPLAY 'LENGTH b"100" wrong: ' TEST-FLD
      *>      END-DISPLAY
      *>   END-IF
           MOVE FUNCTION LENGTH ( x'a0' )
             TO TEST-FLD
           IF TEST-FLD NOT = 1
              DISPLAY 'LENGTH x"a0" wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
           MOVE FUNCTION LENGTH ( z'a0' )
             TO TEST-FLD
           IF TEST-FLD NOT = 3
              DISPLAY 'LENGTH z"a0" wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
           MOVE FUNCTION LENGTH ( n'a0' )
             TO TEST-FLD
           IF TEST-FLD NOT = 2
              DISPLAY 'LENGTH n"a0" wrong: ' TEST-FLD
              END-DISPLAY
           END-IF
           MOVE 10 TO T-ENTRIES
           MOVE FUNCTION LENGTH ( TEST-TAB)
             TO TEST-FLD
           IF TEST-FLD NOT = 12
              DISPLAY 'LENGTH TEST-TAB (10 entries): ' TEST-FLD
              END-DISPLAY
           END-IF
           MOVE 1 TO T-ENTRIES
           MOVE FUNCTION LENGTH ( TEST-TAB)
             TO TEST-FLD
           IF TEST-FLD NOT = 3
              DISPLAY 'LENGTH TEST-TAB (1 entry): ' TEST-FLD
              END-DISPLAY
           END-IF
           STOP RUN.