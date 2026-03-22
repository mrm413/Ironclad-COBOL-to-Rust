IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       78  PROGRAM-NAME  VALUE 'SEQEXTFH'.
       01  FCDOPCODE.
           02  FILLER             PIC X               VALUE X'FA'.
           02  EXTFH-OPCODE       PIC X.
      *    STANDARD OPERATION CODES
           88  EXTFH-OPCODE-ISOPENINPUT               VALUE X'00'.
           88  EXTFH-OPCODE-ISOPENOUTPUT              VALUE X'01'.
           88  EXTFH-OPCODE-ISREADSEQUENTIAL          VALUE X'8D'.
           88  EXTFH-OPCODE-ISCLOSE                   VALUE X'80'.
           88  EXTFH-OPCODE-ISWRITE                   VALUE X'F3'.
       01  FCD-PARAMETER-BLOCK.
           copy xfhfcd3.
       01  LSEQ-FILENAME PIC X(44)
            VALUE 'FCDLS'.
       01  LSEQ-RECORDAREA PIC X(255).
       01  LSEQ-RECORDS.
           02  LSEQ-COUNT             PIC X    COMP-X  VALUE 3.
           02  LSEQ-RECORD1.
               03  LSEQ-1LENGTH       PIC X    COMP-X  VALUE 22.
               03  LSEQ-1DATA         PIC X(80)
               VALUE 'THERE IS LITTLE LAMB'.
           02  LSEQ-RECORD2.
               03  LSEQ-2LENGTH       PIC X    COMP-X  VALUE 33.
               03  LSEQ-2DATA         PIC X(80)
               VALUE 'THE LAMB WAS GRAND AND A GRANDMA'.
           02  LSEQ-RECORD3.
               03  LSEQ-3LENGTH       PIC X    COMP-X  VALUE 22.
               03  LSEQ-3DATA         PIC X(80)
               VALUE 'THE OLD EWE CHORTLED'.
       01  LSEQ-RECORDTABLE
               REDEFINES LSEQ-RECORDS.
           02  LSEQ-TCOUNT            PIC X    COMP-X.
           02  LSEQ-TENTRY            OCCURS 3 TIMES
                                      INDEXED BY LSEQ-TX.
               03  LSEQ-TEST-LEN      PIC X    COMP-X.
               03  LSEQ-TESTDATA      PIC X(80).
       PROCEDURE DIVISION.
           DISPLAY PROGRAM-NAME ': STARTING.'
           DISPLAY PROGRAM-NAME ': CREATING LINE SEQUENTIAL FILE.'
           SET EXTFH-OPCODE-ISOPENOUTPUT      TO TRUE
           MOVE LENGTH OF FCD-PARAMETER-BLOCK TO FCD-LENGTH
           MOVE fcd--version-number           TO FCD-VERSION
           MOVE fcd--open-closed              TO FCD-OPEN-MODE
           MOVE LENGTH OF LSEQ-FILENAME       TO FCD-NAME-LENGTH
           MOVE fcd--exclusive-bit            TO FCD-LOCK-MODE
           MOVE fcd--format-cobol2            TO FCD-FILE-FORMAT
           MOVE LENGTH OF LSEQ-RECORDAREA TO FCD-MAX-REC-LENGTH
           MOVE fcd--recmode-variable TO FCD-RECORDING-MODE
           MOVE 0 TO FCD-MIN-REC-LENGTH
           SET FCD-FILENAME-ADDRESS TO ADDRESS OF LSEQ-FILENAME
           PERFORM CALL-EXTFH
           PERFORM FCD-CHECK-STAT
           IF FCD-FILE-STATUS = '00'
             DISPLAY PROGRAM-NAME
                 ': LINE SEQUENTIAL FILE IS OPEN OUTPUT.'
             PERFORM WITH TEST AFTER VARYING LSEQ-TX FROM 1 BY 1
                 UNTIL LSEQ-TX = LSEQ-TCOUNT OR FCD-FILE-STATUS <> '00'
               SET EXTFH-OPCODE-ISWRITE       TO TRUE
               MOVE LSEQ-TEST-LEN (LSEQ-TX) TO FCD-CURRENT-REC-LEN
               MOVE 1 TO FCD-LINE-COUNT
               SET FCD-RECORD-ADDRESS TO
                ADDRESS OF LSEQ-TESTDATA (LSEQ-TX)
               PERFORM CALL-EXTFH
               PERFORM FCD-CHECK-STAT
             END-PERFORM
             IF FCD-FILE-STATUS = '00'
               DISPLAY PROGRAM-NAME ': LINE SEQUENTIAL WRITES COMPLETE.'
             ELSE
               DISPLAY PROGRAM-NAME
                   ': UNABLE TO CREATE LINE SEQUENTIAL FILE.'
             END-IF
             SET EXTFH-OPCODE-ISCLOSE       TO TRUE
             PERFORM CALL-EXTFH
             PERFORM FCD-CHECK-STAT
             IF FCD-FILE-STATUS = '00'
              DISPLAY PROGRAM-NAME ': LINE SEQUENTIAL FILE IS CLOSED.'
             ELSE
              DISPLAY PROGRAM-NAME
                  ': UNABLE TO CLOSE LINE SEQUENTIAL FILE.'
             END-IF
           ELSE
             DISPLAY PROGRAM-NAME
                 ': UNABLE TO OPEN LINE SEQUENTIAL FILE AS OUTPUT.'
             STOP RUN
           END-IF
           DISPLAY PROGRAM-NAME ': READING LINE SEQUENTIAL FILE.'
           SET EXTFH-OPCODE-ISOPENINPUT       TO TRUE
           MOVE fcd--open-closed              TO FCD-OPEN-MODE
           MOVE LENGTH OF LSEQ-FILENAME       TO FCD-NAME-LENGTH
           MOVE fcd--exclusive-bit            TO FCD-LOCK-MODE
           MOVE LENGTH OF LSEQ-RECORDAREA     TO FCD-MAX-REC-LENGTH
           MOVE 0 TO FCD-MIN-REC-LENGTH
           SET FCD-FILENAME-ADDRESS TO ADDRESS OF LSEQ-FILENAME
           PERFORM CALL-EXTFH
           PERFORM FCD-CHECK-STAT
           IF FCD-FILE-STATUS = '00'
             SET FCD-RECORD-ADDRESS
              TO ADDRESS OF LSEQ-RECORDAREA
             DISPLAY PROGRAM-NAME
                 ': LINE SEQUENTIAL FILE IS OPEN INPUT.'
             PERFORM WITH TEST AFTER UNTIL FCD-FILE-STATUS <> '00'
               SET EXTFH-OPCODE-ISREADSEQUENTIAL  TO TRUE
               PERFORM CALL-EXTFH
               PERFORM FCD-CHECK-STAT
               IF FCD-FILE-STATUS = '00'
                 DISPLAY PROGRAM-NAME
                     ': RECORD = ' LSEQ-RECORDAREA
                                   (1:FCD-CURRENT-REC-LEN)
               END-IF
             END-PERFORM
             IF FCD-FILE-STATUS = '00' OR '10'
               DISPLAY PROGRAM-NAME ': LINE SEQUENTIAL READS COMPLETE.'
             ELSE
               DISPLAY PROGRAM-NAME
                   ': UNABLE TO READ LINE SEQUENTIAL FILE.'
             END-IF
             SET EXTFH-OPCODE-ISCLOSE       TO TRUE
             PERFORM CALL-EXTFH
             PERFORM FCD-CHECK-STAT
             IF FCD-FILE-STATUS = '00'
               DISPLAY PROGRAM-NAME ': LSEQ FILE IS CLOSED.'
             ELSE
               DISPLAY PROGRAM-NAME
                   ': UNABLE TO CLOSE LINE SEQUENTIAL FILE.'
             END-IF
           ELSE
             DISPLAY PROGRAM-NAME
                 ': UNABLE TO OPEN LINE SEQUENTIAL FILE AS INPUT.'
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