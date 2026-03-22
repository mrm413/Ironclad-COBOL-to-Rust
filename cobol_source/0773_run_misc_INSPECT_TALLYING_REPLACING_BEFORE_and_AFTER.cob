IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  INSP-STRING   PIC X(26) VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
       01  EXPTD-RESULT  CONSTANT AS     'A22222111111111122222222YZ'.
       01  RES-IDX       PIC 9(04) BINARY VALUE 100.
       01  RES-IDX-1     PIC 9(04) BINARY VALUE 0.
       PROCEDURE DIVISION.
      *>
           INSPECT INSP-STRING
                   TALLYING RES-IDX   FOR CHARACTERS BEFORE 'H'
                            RES-IDX-1 FOR CHARACTERS AFTER  'B'
             REPLACING
                   CHARACTERS BY '1' AFTER 'F' BEFORE 'Q'
                   CHARACTERS BY '2' AFTER 'A' BEFORE 'Y'.
      *>
           IF INSP-STRING NOT = EXPTD-RESULT
               DISPLAY 'Failed <' INSP-STRING '> != <' EXPTD-RESULT '>'.
           IF RES-IDX NOT = 107
               DISPLAY 'Failed <' RES-IDX   '> != <107>'.
           IF RES-IDX-1 NOT = 19
               DISPLAY 'Failed <' RES-IDX-1 '> != <19>'.
      *>
           GOBACK.