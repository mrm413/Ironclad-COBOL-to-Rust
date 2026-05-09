IDENTIFICATION DIVISION.
       PROGRAM-ID. JUST00.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77  ELE                         PIC X(10) JUSTIFIED RIGHT.
       77  SHORT                       PIC X(4)  VALUE 'ABC '.
       77  LONG                        PIC X(16)
               VALUE 'ABCDEFGHIGKLMNOP'.

       PROCEDURE DIVISION.
           MOVE 'ABC '                 TO ELE
           IF ELE NOT EQUAL '      ABC '
               DISPLAY 'MOVE WITH SHORT FIELD JUSTIFIED HAS FAILED: '
               '"' ELE '"'.

           MOVE 'ABCDEFGHIGKLMNOP'     TO ELE
           IF ELE NOT EQUAL 'GHIGKLMNOP'
               DISPLAY 'MOVE WITH LONG FIELD JUSTIFIED HAS FAILED: '
               '"' ELE '"'.

           MOVE SHORT                  TO ELE
           IF ELE NOT EQUAL '      ABC '
               DISPLAY 'MOVE WITH SHORT FIELD JUSTIFIED HAS FAILED: '
               '"' ELE '"'.

           MOVE LONG                   TO ELE
           IF ELE NOT EQUAL 'GHIGKLMNOP'
               DISPLAY 'MOVE WITH LONG FIELD JUSTIFIED HAS FAILED: '
               '"' ELE '"'.

           STOP RUN.