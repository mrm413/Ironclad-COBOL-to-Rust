IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  dummy        PIC X(5).
       01  success-flag PIC X.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr.
           03                PIC X(80) VALUE 'Enter "y" in the bottom'
                             & ' field if:'.
           03  LINE + 1,     PIC X(80) VALUE ' * when the left field is'
                             & ' full, the cursor automatically moves'.
           03  LINE + 1,     PIC X(80) VALUE '   to the next field.'.
           03  LINE + 1,     PIC X(80) VALUE ' * this does not happen'
                             & ' with the other fields.'.
           03  LINE + 1,     PIC X(80) VALUE ' * the fields below are'
                             & ' on one line and separated by a single'
                             & ' column.'.

           03  test-fields   LINE + 2.
               05  field-1   COL 1, PIC X(5) AUTO TO dummy.
               05  field-2   COL + 2, PIC X(5) TO dummy.
               05  field-3   COL + 2, PIC X(5) TO dummy.
           03  success-field LINE + 2, COLUMN 1; PIC X, REQUIRED
                             TO success-flag FROM 'Y'.

       PROCEDURE DIVISION.
           DISPLAY scr
           ACCEPT scr

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .