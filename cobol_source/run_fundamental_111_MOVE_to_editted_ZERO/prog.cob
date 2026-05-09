IDENTIFICATION DIVISION.
       PROGRAM-ID. MoveToEditedZero .
      *>----------------------------------------------------------------
      *>           Additional test cases for MOVE statement
      *> Move To Edited
      *>    Edited field contains only '*'  and sending field is ZERO
      *>----------------------------------------------------------------
      *>
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 DISP-1       PIC 999999  .
       01 EDIT-1       PIC ****** .
       01 EDIT-1-X     REDEFINES EDIT-1 PIC X(06) .

      *>
       PROCEDURE DIVISION .
      *>
           MOVE 111111 TO EDIT-1 *> avoid init by default
      *>
           MOVE ZEROES  TO DISP-1 .
           MOVE DISP-1  TO EDIT-1 .
           IF EDIT-1-X NOT = '******'
           THEN
               DISPLAY 'Error EDIT-1-X <' EDIT-1-X '> !=  <******>' .
      *>
      *>
           MOVE 123     TO DISP-1 .
           MOVE DISP-1  TO EDIT-1 .
           IF EDIT-1-X NOT = '***123'
           THEN
               DISPLAY 'Error EDIT-1-X <' EDIT-1-X '> !=  <***123>' .
      *>
           GOBACK .