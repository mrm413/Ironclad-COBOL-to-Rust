IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
      ** TEST FIXED (BLOCK) LENGTH SEQUENTIAL RECORD EXTFH
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       78  PROGRAM-NAME  VALUE 'FBSEXTFH'.
       01  FCDOPCODE.
           02  FILLER              PIC X               VALUE X'FA'.
           02  EXTFH-OPCODE        PIC X.
      *    STANDARD OPERATION CODES
           88  EXTFH-OPCODE-ISOPENINPUT               VALUE X'00'.
           88  EXTFH-OPCODE-ISOPENOUTPUT              VALUE X'01'.
           88  EXTFH-OPCODE-ISREADSEQUENTIAL          VALUE X'8D'.
           88  EXTFH-OPCODE-ISCLOSE                   VALUE X'80'.
           88  EXTFH-OPCODE-ISWRITE                   VALUE X'F3'.
      *
       01  FCD-PARAMETER-BLOCK.
           copy xfhfcd3.
       01  FIX-FILENAME PIC X(44)
            VALUE 'FCDFB'.
       01  FIX-RECORDAREA PIC X(255).
       01  FIX-RECORDS.
           02  FIX-COUNT              PIC X    COMP-X  VALUE 3.
           02  FIX-RECORD1.
               03  FIX-1LENGTH        PIC X    COMP-X  VALUE 22.
               03  FIX-1DATA          PIC X(80)
               VALUE 'THERE IS LITTLE LAMB'.
           02  FIX-RECORD2.
               03  FIX-2LENGTH        PIC X    COMP-X  VALUE 33.
               03  FIX-2DATA          PIC X(80)
               VALUE 'THE LAMB WAS GRAND AND A GRANDMA'.
           02  FIX-RECORD3.
               03  FIX-3LENGTH        PIC X    COMP-X  VALUE 22.
               03  FIX-3DATA          PIC X(80)
               VALUE 'THE OLD EWE CHORTLED'.
       01  FIX-RECORDTABLE
               REDEFINES FIX-RECORDS.
           02  FIX-TCOUNT             PIC X    COMP-X.
           02  FIX-TENTRY             OCCURS 3 TIMES
                                      INDEXED BY FIX-TX.
               03  FIX-TEST-LEN       PIC X    COMP-X.
               03  FIX-TESTDATA       PIC X(80).
       PROCEDURE DIVISION.
           DISPLAY PROGRAM-NAME ': STARTING.'
           DISPLAY PROGRAM-NAME ': CREATING FIXED  SEQ FILE.'
           SET EXTFH-OPCODE-ISOPENOUTPUT      TO TRUE
           MOVE LENGTH OF FCD-PARAMETER-BLOCK TO FCD-LENGTH
           move fcd--version-number TO FCD-VERSION
           MOVE fcd--sequential-org TO FCD-ORGANIZATION
           MOVE fcd--open-closed TO FCD-OPEN-MODE
           MOVE LENGTH OF FIX-FILENAME TO FCD-NAME-LENGTH
           MOVE fcd--exclusive-bit TO FCD-LOCK-MODE
           move fcd--format-cobol2 to FCD-FILE-FORMAT
           MOVE LENGTH OF FIX-RECORDAREA TO FCD-MAX-REC-LENGTH
           MOVE 0 TO FCD-MIN-REC-LENGTH
           SET FCD-FILENAME-ADDRESS TO ADDRESS OF FIX-FILENAME
           MOVE 80 TO FCD-CURRENT-REC-LEN
           MOVE 80 TO FCD-MAX-REC-LENGTH
           MOVE 80 TO FCD-MIN-REC-LENGTH
           PERFORM CALL-EXTFH
           PERFORM FCD-CHECK-STAT
           IF FCD-FILE-STATUS = '00'
             DISPLAY PROGRAM-NAME
                 ': FIXED  SEQ FILE IS OPEN OUTPUT.'
             PERFORM WITH TEST AFTER VARYING FIX-TX FROM 1 BY 1
                 UNTIL FIX-TX = FIX-TCOUNT OR FCD-FILE-STATUS <> '00'
               SET EXTFH-OPCODE-ISWRITE       TO TRUE
               MOVE FIX-TEST-LEN (FIX-TX) TO FCD-CURRENT-REC-LEN
               MOVE 1 TO FCD-LINE-COUNT
               SET FCD-RECORD-ADDRESS TO
                ADDRESS OF FIX-TESTDATA (FIX-TX)
               PERFORM CALL-EXTFH
               PERFORM FCD-CHECK-STAT
             END-PERFORM
             IF FCD-FILE-STATUS = '00'
               DISPLAY PROGRAM-NAME ': FIXED  SEQ WRITES COMPLETE.'
             ELSE
               DISPLAY PROGRAM-NAME
                   ': UNABLE TO CREATE FIXED  SEQ FILE.'
             END-IF
             SET EXTFH-OPCODE-ISCLOSE       TO TRUE
             PERFORM CALL-EXTFH
             PERFORM FCD-CHECK-STAT
             IF FCD-FILE-STATUS = '00'
              DISPLAY PROGRAM-NAME ': FIXED  SEQ FILE IS CLOSED.'
             ELSE
              DISPLAY PROGRAM-NAME
                  ': UNABLE TO CLOSE FIXED  SEQ FILE.'
             END-IF
           ELSE
             DISPLAY PROGRAM-NAME
                 ': UNABLE TO OPEN FIXED  SEQ FILE AS OUTPUT.'
             STOP RUN
           END-IF
           DISPLAY PROGRAM-NAME ': READING FIXED  SEQ FILE.'
           SET EXTFH-OPCODE-ISOPENINPUT       TO TRUE
           MOVE fcd--sequential-org TO FCD-ORGANIZATION
           MOVE fcd--open-closed TO FCD-OPEN-MODE
           MOVE LENGTH OF FIX-FILENAME TO FCD-NAME-LENGTH
           MOVE fcd--exclusive-bit TO FCD-LOCK-MODE
           move fcd--format-cobol2 to FCD-FILE-FORMAT
           MOVE LENGTH OF FIX-RECORDAREA TO FCD-MAX-REC-LENGTH
           MOVE 0 TO FCD-MIN-REC-LENGTH
           SET FCD-FILENAME-ADDRESS TO ADDRESS OF FIX-FILENAME
           MOVE 80 TO FCD-CURRENT-REC-LEN
           MOVE 80 TO FCD-MAX-REC-LENGTH
           MOVE 80 TO FCD-MIN-REC-LENGTH
           PERFORM CALL-EXTFH
           PERFORM FCD-CHECK-STAT
           IF FCD-FILE-STATUS = '00'
             DISPLAY PROGRAM-NAME
                 ': FIXED  SEQ FILE IS OPEN INPUT.'
             PERFORM WITH TEST AFTER UNTIL FCD-FILE-STATUS <> '00'
               SET EXTFH-OPCODE-ISREADSEQUENTIAL  TO TRUE
               SET FCD-RECORD-ADDRESS
                TO ADDRESS OF FIX-RECORDAREA
               PERFORM CALL-EXTFH
               PERFORM FCD-CHECK-STAT
               IF FCD-FILE-STATUS = '00'
                 DISPLAY PROGRAM-NAME
                     ': RECORD = ' FIX-RECORDAREA (1:40) '. '
                     'Size:' FCD-CURRENT-REC-LEN
               END-IF
             END-PERFORM
             IF FCD-FILE-STATUS = '00' OR '10'
               DISPLAY PROGRAM-NAME ': FIXED  SEQ READS COMPLETE.'
             ELSE
               DISPLAY PROGRAM-NAME
                   ': UNABLE TO READ FIXED  SEQ FILE.'
             END-IF
             SET EXTFH-OPCODE-ISCLOSE       TO TRUE
             PERFORM CALL-EXTFH
             PERFORM FCD-CHECK-STAT
             IF FCD-FILE-STATUS = '00'
               DISPLAY PROGRAM-NAME ': LSEQ FILE IS CLOSED.'
             ELSE
               DISPLAY PROGRAM-NAME
                   ': UNABLE TO CLOSE FIXED  SEQ FILE.'
             END-IF
           ELSE
             DISPLAY PROGRAM-NAME
                 ': UNABLE TO OPEN FIXED  SEQ FILE AS INPUT.'
             STOP RUN
           END-IF
           DISPLAY PROGRAM-NAME ': ENDING.'
           STOP RUN.
       CALL-EXTFH.
           CALL 'EXTFH' USING
                        FCDOPCODE
                        FCD-PARAMETER-BLOCK.
       FCD-CHECK-STAT.
           IF FCD-STATUS-KEY-1 = '9'
             DISPLAY PROGRAM-NAME ': RUN-TIME ERROR 9/' FCD-BINARY
           ELSE
             IF FCD-FILE-STATUS <> '00'
               DISPLAY PROGRAM-NAME ': FILE STATUS = ' FCD-FILE-STATUS
             ELSE
               CONTINUE
             END-IF
           END-IF.
       SEQEXTFH-TERM.
           EXIT.