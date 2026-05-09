IDENTIFICATION DIVISION.
       PROGRAM-ID . MoveOtherCases .
      *>----------------------------------------------------------------
      *>           Additional test cases for MOVE statement
      *> Last several specifics test cases
      *>----------------------------------------------------------------
      *>
       ENVIRONMENT DIVISION.
      *>-------------

       DATA DIVISION .
      *>--------------

       WORKING-STORAGE SECTION.
      *>-----------------------

       01  SRC-BIN        PIC S9(09) BINARY .
       01  DST-BIN        PIC  9(09) BINARY .
      *>
       01  SRC-EDIT       PIC $$$$,$$9V99-  .
       01  DST-DISP       PIC  9(06)        .
      *>
       01  DST-FIELD-1    PIC XB0XB099/ .

      *>
       PROCEDURE DIVISION .
      *>-------------------
      *>
      *>   Case 1 move unsigned to signed
      *>
           MOVE -12345678     TO SRC-BIN    .
           MOVE SRC-BIN       TO DST-BIN    .
           IF DST-BIN NOT = 12345678
           THEN
               DISPLAY '1: DST-BIN <' DST-BIN '>!= <12345678>'  .

      *>
      *>   Case 2 move negative edited to display
      *>
           MOVE -3            TO SRC-EDIT .
           MOVE SRC-EDIT      TO DST-DISP .
           IF SRC-EDIT NOT = '      $300-'
           THEN
             DISPLAY '2: SRC-EDIT <' SRC-EDIT '> != <      $300->'  .
      *>
           IF DST-DISP NOT = 3
           THEN
             DISPLAY '2.1: DST-DISP <' DST-DISP '> != <3>'  .


      *>
      *>   Case 3 cob_move alphanum to  edited case
      *>
           MOVE 3          TO SRC-EDIT     .
           MOVE SRC-EDIT   TO DST-FIELD-1  .

           IF DST-FIELD-1 NOT = '  0  0  /'
           THEN
             DISPLAY '3: DST-FIELD-1 <' DST-FIELD-1 '> != <  0  0  />'.

      *>
           GOBACK .