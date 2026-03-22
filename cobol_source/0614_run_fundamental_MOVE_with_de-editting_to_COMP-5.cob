IDENTIFICATION DIVISION.
       PROGRAM-ID. MoveDeEditing_5.
      *>----------------------------------------------------------------
      *>           Additional test cases for MOVE statement
      *> CHECK DE-EDITING
      *>    Receiving field is COMP-5 Type
      *>----------------------------------------------------------------
      *>
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  EDIT-1               PIC $(4)9.99CR.
       01  DISP-1               PIC S9(4)V99 COMP-5 .
       01  EDIT-2               PIC --9B.99B99/99.
       01  DISP-2               PIC S99V9(6) COMP-5 .


       PROCEDURE DIVISION .

           MOVE -123.45 TO EDIT-1       .
           MOVE  EDIT-1 TO DISP-1       .
           IF    DISP-1 NOT = -123.45
           THEN
                 DISPLAY 'Error 1: DISP-1 <' DISP-1 '> != -0123.45' .

           IF    EDIT-1 NOT = " $123.45CR"
           THEN
                 DISPLAY 'Error 2: EDIT-1 <' EDIT-1 '> != < $123.45CR>'.

           MOVE -42.9876 TO EDIT-2.
           MOVE  EDIT-2 TO DISP-2.
           IF    DISP-2 NOT = -42.987600
           THEN
              DISPLAY 'Error 3: DISP-2 <' DISP-2 '> != <-42.987600>'.

           IF   EDIT-2 NOT = "-42 .98 76/00"
           THEN
              DISPLAY 'Error 4: EDIT-2 <' EDIT-2 '> != <-42 .98 76/00>'.


           GOBACK .