IDENTIFICATION DIVISION.
        PROGRAM-ID.  MoveEditedToDisplay.
      *>----------------------------------------------------------------
      *>           Additional test cases for MOVE statement
      *>   Add more test case for edited field
      *>----------------------------------------------------------------
      *>

        ENVIRONMENT DIVISION.

        DATA DIVISION.
        WORKING-STORAGE SECTION.

        01 EDITED-FIELD .


           05 SRC-FIELD-100   PIC +$ZZ9999900BB9   .
           05 SRC-FIELD-101   PIC -$ZZ9999900BB9   .
           05 SRC-FIELD-102   PIC  $ZZ9999900BB9CR .
           05 SRC-FIELD-103   PIC  $ZZ9999900BB9DB .
           05 SRC-FIELD-400   PIC +$**9999900BB9   .
           05 SRC-FIELD-401   PIC -$**9999900BB9   .
           05 SRC-FIELD-402   PIC  $**9999900BB9CR .
           05 SRC-FIELD-403   PIC  $**9999900BB9DB .
      *
        01 DST-FIELD.
           05 DST-FIELD-1     PIC 9(10)V9(04) .
           05 DST-FIELD-2     PIC S9(10)V9(04) .
      *
        PROCEDURE DIVISION.
      *>-------------------
      *>
           MOVE 12345      TO SRC-FIELD-100  .
           MOVE SRC-FIELD-100 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 1234005
              DISPLAY '1: DST-FIELD-1 <' DST-FIELD-1 '> != 1234005' .
      *>
           MOVE 23456      TO SRC-FIELD-101  .
           MOVE SRC-FIELD-101 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 2345006
              DISPLAY '2: DST-FIELD-1 <' DST-FIELD-1 '> != 2345006' .
      *>
           MOVE 34567      TO SRC-FIELD-102  .
           MOVE SRC-FIELD-102 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 3456007
              DISPLAY '3: DST-FIELD-1 <' DST-FIELD-1 '> != 3456007' .
      *>
           MOVE 45678      TO SRC-FIELD-103  .
           MOVE SRC-FIELD-103 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 4567008
              DISPLAY '4: DST-FIELD-1 <' DST-FIELD-1 '> != 4567008' .
      *>
      *>--------------------------------------------------------------
      *>
           MOVE -12345      TO SRC-FIELD-100  .
           MOVE SRC-FIELD-100 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = 1234005
               DISPLAY '5: DST-FIELD-2 <' DST-FIELD-2 '> != 1234005' .
      *>
           MOVE -23456      TO SRC-FIELD-101  .
           MOVE SRC-FIELD-101 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = -2345006
              DISPLAY '6: DST-FIELD-2 <' DST-FIELD-2 '> != -2345006' .
      *>
           MOVE -34567      TO SRC-FIELD-102  .
           MOVE SRC-FIELD-102 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = -3456007
              DISPLAY '7: DST-FIELD-2 <' DST-FIELD-2 '> != -3456007' .
      *>
           MOVE -45678      TO SRC-FIELD-103  .
           MOVE SRC-FIELD-103 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = 4567008
              DISPLAY '8: DST-FIELD-2 <' DST-FIELD-2 '> != 45676008' .
      *>
      *>--------------------------------------------------------------
      *>
           MOVE 12345      TO SRC-FIELD-400  .
           MOVE SRC-FIELD-400 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 1234005
              DISPLAY '9: DST-FIELD-1 <' DST-FIELD-1 '> != 1234005' .
      *>
           MOVE 23456      TO SRC-FIELD-401  .
           MOVE SRC-FIELD-401 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 2345006
              DISPLAY '10: DST-FIELD-1 <' DST-FIELD-1 '> != 2345006' .
      *>
           MOVE 34567      TO SRC-FIELD-402  .
           MOVE SRC-FIELD-402 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 3456007
              DISPLAY '11: DST-FIELD-1 <' DST-FIELD-1 '> != 3456007' .
      *>
           MOVE 45678      TO SRC-FIELD-403  .
           MOVE SRC-FIELD-403 TO DST-FIELD-1 .
           IF DST-FIELD-1 NOT = 4567008
              DISPLAY '12: DST-FIELD-1 <' DST-FIELD-1 '1 != 45676008' .
      *>
           MOVE -12345     TO SRC-FIELD-400  .
           MOVE SRC-FIELD-400 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = 1234005
              DISPLAY '13: DST-FIELD-2 <' DST-FIELD-2 '> != 1234005' .
      *>
           MOVE -23456      TO SRC-FIELD-401  .
           MOVE SRC-FIELD-401 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = -2345006
              DISPLAY '14: DST-FIELD-2 <' DST-FIELD-2 '> != -2345006' .
      *>
           MOVE -34567      TO SRC-FIELD-402  .
           MOVE SRC-FIELD-402 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = -3456007
              DISPLAY '15: DST-FIELD-2 <' DST-FIELD-2 '> != -3456007' .
      *>
           MOVE -45678      TO SRC-FIELD-403  .
           MOVE SRC-FIELD-403 TO DST-FIELD-2 .
           IF DST-FIELD-2 NOT = 4567008
              DISPLAY '16: DST-FIELD-2 <' DST-FIELD-2 '> != 4567008' .
      *>
           GOBACK .