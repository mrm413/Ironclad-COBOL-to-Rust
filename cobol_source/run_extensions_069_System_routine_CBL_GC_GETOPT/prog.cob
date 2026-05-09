IDENTIFICATION DIVISION.
        PROGRAM-ID. prog.
      *> check combination of long and short options
        DATA DIVISION.
        WORKING-STORAGE SECTION.
           01 LO.
                05 OPTIONRECORD OCCURS 2 TIMES.
                    10 ONAME        PIC X(25).
                    10 HAS-VALUE    PIC 9.
                    10 VALPOINT     POINTER     VALUE NULL.
                    10 VAL          PIC X(4).

            01 SO             PIC X(256).
            01 LONGIND        PIC 99.
            01 LONG-ONLY      PIC 9 VALUE 1.
            01 RETURN-CHAR    PIC X(4).
            01 OPT-VAL        PIC X(10).
            01 RET-DISP       PIC S9 VALUE 0.

            01 COUNTER        PIC 9 VALUE 0.
        PROCEDURE DIVISION.
            MOVE "jkl"     TO SO.

            MOVE "version" TO ONAME     (1).
            MOVE 0         TO HAS-VALUE (1).
            MOVE "v"       TO VAL       (1).

            MOVE "verbose" TO ONAME     (2).
            MOVE 0         TO HAS-VALUE (2).
            MOVE "V"       TO VAL       (2).

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
                     IF RETURN-CHAR NOT = 'v' THEN
                        DISPLAY '0-ERROR: ' RETURN-CHAR END-DISPLAY
                     END-IF
                  WHEN 1
                     IF RETURN-CHAR NOT = 'V' THEN
                        DISPLAY '1-ERROR: ' RETURN-CHAR END-DISPLAY
                     END-IF
                  WHEN 2
                     IF RETURN-CHAR NOT = 'j' THEN
                        DISPLAY '2-ERROR: ' RETURN-CHAR END-DISPLAY
                     END-IF
                  WHEN 3
                     IF RETURN-CHAR NOT = 'k' THEN
                        DISPLAY '3-ERROR: ' RETURN-CHAR END-DISPLAY
                     END-IF
                  WHEN 4
                     IF RETURN-CHAR NOT = 'l' THEN
                        DISPLAY '4-ERROR: ' RETURN-CHAR END-DISPLAY
                     END-IF
                  WHEN 5
                     IF RETURN-CODE NOT = -1 THEN
                        MOVE RETURN-CODE TO RET-DISP
                        DISPLAY 'last RETURN-CODE wrong: ' RET-DISP
                        END-DISPLAY
                     END-IF
                     EXIT PERFORM
               END-EVALUATE
            END-PERFORM.

            MOVE 0 TO RETURN-CODE.

            IF COUNTER NOT = 5 THEN
               MOVE RETURN-CODE TO RET-DISP
               DISPLAY 'CBL_GC_GETOPT returned -1 too early: ' COUNTER
               END-DISPLAY
            END-IF.

            STOP RUN.