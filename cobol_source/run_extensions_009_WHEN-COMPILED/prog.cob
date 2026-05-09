IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(20).
       PROCEDURE        DIVISION.
           MOVE WHEN-COMPILED TO X.
           INSPECT X CONVERTING "0123456789" TO "9999999999".
           IF X NOT = "99/99/9999.99.99    "
              CALL 'CBL_OC_DUMP' USING X
                 ON EXCEPTION
                    DISPLAY X NO ADVANCING
                    END-DISPLAY
              END-CALL
           END-IF
           STOP RUN.