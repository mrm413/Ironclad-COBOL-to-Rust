IDENTIFICATION DIVISION.
        PROGRAM-ID. prog5.
      *> check for wrong longoption structure
        DATA DIVISION.
        WORKING-STORAGE SECTION.
            01 SO PIC X.
            01 LO.
                05 OPTIONRECORD OCCURS 2 TIMES.
                    10 ONAME        PIC X(45).
                    10 HAS-VALUE    PIC 9.
                    10 VALPOINT     POINTER     VALUE NULL.
                    10 VAL          PIC X(4).
            01 LONGIND       PIC 99.
            01 LONG-ONLY     PIC 9 VALUE 1.
            01 RETURN-CHAR   PIC X(4).
            01 OPT-VAL       PIC X(10).
            01 RET-DISP      PIC S999 VALUE 0.

            01 COUNTER       PIC 9 VALUE 0.

            01 FLAG-VAL      PIC 9.
        PROCEDURE DIVISION.
            MOVE "super-long-option-with-more-than-25-bytes"
              TO ONAME(1).
            MOVE 0   TO HAS-VALUE(1).
            MOVE '1' TO VAL(1).

            MOVE "stupid-long-option-with-more-than-25-bytes"
              TO ONAME(2).
            MOVE 0   TO HAS-VALUE(2).
            MOVE '0' TO VAL(2).

            PERFORM WITH TEST AFTER
                    VARYING COUNTER FROM 0 BY 1
                    UNTIL RETURN-CODE = -1
               CALL 'CBL_GC_GETOPT' USING
                  BY REFERENCE SO LO LONGIND
                  BY VALUE     LONG-ONLY
                  BY REFERENCE RETURN-CHAR OPT-VAL
               END-CALL

               EVALUATE COUNTER
                  WHEN 0
                  WHEN 1
                  WHEN 2
                     CONTINUE

      *>       MOVE RETURN-CODE TO RET-DISP

      *>       IF COUNTER = 0 AND RETURN-CODE NOT = 1 THEN
      *>          DISPLAY 'RETURN VALUE: ' RET-DISP ' ' FLAG-VAL
      *>       END-IF
                  WHEN 3
                     IF RETURN-CODE NOT = -1 THEN
                        MOVE RETURN-CODE TO RET-DISP
                        DISPLAY 'last RETURN-CODE wrong: ' RET-DISP
                        END-DISPLAY
                     END-IF
                     EXIT PERFORM
               END-EVALUATE
            END-PERFORM.

            MOVE 0 TO RETURN-CODE.

            IF COUNTER NOT = 3 THEN
               MOVE RETURN-CODE TO RET-DISP
               DISPLAY 'CBL_GC_GETOPT returned -1 too early: ' COUNTER
               END-DISPLAY
            END-IF.

            STOP RUN.