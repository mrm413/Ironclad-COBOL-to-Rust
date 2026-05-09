IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE SECTION.
       77  window-handle USAGE HANDLE OF WINDOW.
       77  lb-row        PIC X(10).
       77  lb-color      PIC 9(05) VALUE 8192.
       77  lb-num-lines  PIC 9(02) VALUE 20.
       77  lb-num-rows   PIC 9(02) VALUE 11.
       77  window-lines  PIC 9(02) VALUE 22.
       77  window-rows   PIC 9(02) VALUE 13.
       77  selection-idx PIC S9(02).
       SCREEN SECTION.
       01 lb-screen.
           03 lb-frm LIST-BOX 3-D
      *             FIXME: the following should be possible in any order
                    UNSORTED
                    EXCEPTION-VALUE = 13
                    COLOR lb-color
                    CLINE 1 CCOL 1
                    LINES = lb-num-lines
                    SIZE  IS lb-num-rows
      *             VALUE lb-row  raises error as no identifer according
      *                           to cobol2002, but here it is fine
                    .
       PROCEDURE DIVISION.
       MAIN.
           MODIFY lb-frm ITEM-TO-ADD = 'Row 1'
           MODIFY lb-frm ITEM-TO-ADD = 'Row 2'
           MODIFY lb-frm ITEM-TO-ADD = 'Row 3'
           MODIFY lb-frm ITEM-TO-ADD = 'Row 4'
           MODIFY lb-frm ITEM-TO-ADD = 'Row 5'
           MODIFY lb-frm ITEM-TO-ADD = 'Row 6'
           MODIFY lb-frm ITEM-TO-ADD = 'Row 7'
           DISPLAY FLOATING WINDOW
               LINE 5 COL 5
               LINES window-lines
               SIZE  window-rows
               BOXED
               COLOR lb-color
               HANDLE IS window-handle
           END-DISPLAY
           DISPLAY lb-screen
           ACCEPT  lb-screen
           IF lb-row = SPACES
              INQUIRE lb-frm SELECTION-INDEX IN selection-idx
              IF selection-idx > ZERO
                 MODIFY  lb-frm QUERY-INDEX = selection-idx
                 INQUIRE lb-frm ITEM-VALUE IN lb-row
              END-IF
           END-IF
           CLOSE WINDOW window-handle
           DISPLAY "chosen row value was '" lb-row "'"
           ACCEPT OMITTED
      *
           STOP RUN.