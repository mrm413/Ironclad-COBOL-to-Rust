IDENTIFICATION DIVISION.
        PROGRAM-ID. prog4.
      *> check use of value pointer and trimming of opt-val
        DATA DIVISION.
        WORKING-STORAGE SECTION.
            01 SO PIC X(12).
            01 LO.
                05 OPTIONRECORD OCCURS 3 TIMES.
                    10 ONAME        PIC X(25).
                    10 HAS-VALUE    PIC 9.
                    10 VALPOINT     POINTER     VALUE NULL.
                    10 VAL          PIC X(4).
            01 LONGIND          PIC 99.
            01 LONG-ONLY        PIC 9 VALUE 1.
            01 RETURN-CHAR      PIC X(4).
            01 OPT-VAL          PIC X(10).
            01 RET-DISP         PIC S999 VALUE 0.

            01 COUNTER          PIC 9 VALUE 0.

            01 FLAG-VAL         PIC X(4).
        procedure division.
            MOVE "jkl"       TO SO.

            MOVE "static"    TO ONAME     (1).
            MOVE 0           TO HAS-VALUE (1).
            SET  VALPOINT(1) TO ADDRESS OF FLAG-VAL.
            MOVE '1'         TO VAL       (1).

            MOVE "dynamic"   TO ONAME     (2).
            MOVE 0           TO HAS-VALUE (2).
            SET  VALPOINT(2) TO ADDRESS OF FLAG-VAL.
            MOVE '0'         TO VAL       (2).

            MOVE "usage"     TO ONAME     (3).
            MOVE 1           TO HAS-VALUE (3).
            MOVE 'u'         TO VAL       (3).

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
                     IF RETURN-CODE NOT = 0 OR
                        FLAG-VAL    NOT = '1' THEN
                        DISPLAY '0-ERROR: ' RET-DISP ' ' FLAG-VAL
                        END-DISPLAY
                     END-IF
                  WHEN 1
                     IF RETURN-CODE NOT = 0 OR
                        FLAG-VAL    NOT = '0' THEN
                        DISPLAY '1-ERROR: ' RET-DISP ' ' FLAG-VAL
                        END-DISPLAY
                     END-IF
                  WHEN 2
                     IF RETURN-CHAR NOT = 'u' OR
                        RETURN-CODE NOT = 2 THEN
                        DISPLAY '2-ERROR: ' RET-DISP ' ' FLAG-VAL
                        END-DISPLAY
                     END-IF
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