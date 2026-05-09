IDENTIFICATION DIVISION.
      *
       PROGRAM-ID. prog.
       DATA DIVISION.

       WORKING-STORAGE SECTION.

       77  I                               PIC 9(04) COMP-5.
       77  J                               PIC 9(04) COMP-5.
       77  K                               PIC 9(04) COMP-5.
       77  L                               PIC 9(04) COMP-5.
       77  M                               PIC 9(04) COMP-5.
       01  OP-N                            PIC X COMP-X.
       01  OP-X REDEFINES OP-N             PIC X.

       01  ACTION-CODE.
           05  ACTION-TYPE    PIC X(01).
               78  COBOL-TYPE                  VALUE X'FA'.
               78  SPECIAL-TYPE                VALUE X'00'.
           05  COBOL-OP       PIC X(01).
               78  OPEN-INPUT                  VALUE X'00'.
               78  OPEN-OUTPUT                 VALUE X'01'.
               78  OPEN-I-O                    VALUE X'02'.
               78  OPEN-EXTEND                 VALUE X'03'.
               78  OPEN-INPUT-NO-REWIND        VALUE X'04'.
               78  OPEN-OUTPUT-NO-REWIND       VALUE X'05'.
               78  OPEN-INPUT-REVERSED         VALUE X'08'.
               78  CLOSE-FILE                  VALUE X'80'.
               78  CLOSE-LOCK                  VALUE X'81'.
               78  CLOSE-NO-REWIND             VALUE X'82'.
               78  CLOSE-REEL-UNIT             VALUE X'84'.
               78  CLOSE-REEL-UNIT-FOR-REMOVAL VALUE X'85'.
               78  CLOSE-REEL-UNIT-NO-REWIND   VALUE X'86'.
               78  READ-SEQ-NO-LOCK            VALUE X'8D'.
               78  READ-SEQ-LOCK               VALUE X'D8'.
               78  READ-SEQ-KEPT-LOCK          VALUE X'D9'.
               78  READ-SEQ                    VALUE X'F5'.
               78  READ-PREVIOUS-NO-LOCK       VALUE X'8C'.
               78  READ-PREVIOUS-LOCK          VALUE X'DE'.
               78  READ-PREVIOUS-KEPT-LOCK     VALUE X'DF'.
               78  READ-PREVIOUS               VALUE X'F9'.
               78  READ-RANDOM-NO-LOCK         VALUE X'8E'.
               78  READ-RANDOM-LOCK            VALUE X'DA'.
               78  READ-RANDOM-KEPT-LOCK       VALUE X'DB'.
               78  READ-RANDOM                 VALUE X'F6'.
               78  READ-DIRECT-NO-LOCK         VALUE X'8F'.
               78  READ-DIRECT-LOCK            VALUE X'D6'.
               78  READ-DIRECT-KEPT-LOCK       VALUE X'D7'.
               78  READ-DIRECT                 VALUE X'C9'.
               78  READ-POSITION               VALUE X'F1'.
               78  WRITE-BEFORE                VALUE X'E1'.
               78  WRITE-AFTER                 VALUE X'E2'.
               78  WRITE-BEFORE-TAB            VALUE X'E3'.
               78  WRITE-AFTER-TAB             VALUE X'E4'.
               78  WRITE-BEFORE-PAGE           VALUE X'E5'.
               78  WRITE-AFTER-PAGE            VALUE X'E6'.
               78  WRITE-RECORD                VALUE X'F3'.
               78  REWRITE-RECORD              VALUE X'F4'.
               78  START-EQUAL-PRIME-KEY       VALUE X'E8'.
               78  START-EQUAL-KEY             VALUE X'E9'.
               78  START-GREATER               VALUE X'EA'.
               78  START-NOT-LESS              VALUE X'EB'.
               78  START-LESS                  VALUE X'FE'.
               78  START-LESS-OR-EQUAL         VALUE X'FF'.
               78  STEP-NEXT-NO-LOCK           VALUE X'90'.
               78  STEP-NEXT-LOCK              VALUE X'D4'.
               78  STEP-NEXT-KEPT-LOCK         VALUE X'D5'.
               78  STEP-NEXT                   VALUE X'CA'.
               78  STEP-FIRST-NO-LOCK          VALUE X'92'.
               78  STEP-FIRST-LOCK             VALUE X'D0'.
               78  STEP-FIRST-KEPT-LOCK        VALUE X'D1'.
               78  STEP-FIRST                  VALUE X'CC'.
               78  DELETE-RECORD               VALUE X'F7'.
               78  DELETE-FILE                 VALUE X'F8'.
               78  UNLOCK-CURRENT              VALUE X'0E'.
               78  COMMIT-ALL                  VALUE X'DC'.
               78  ROLLBACK-ALL                VALUE X'DD'.
               78  GET-FILE-INFO               VALUE X'06'.
               78  OPEN-NEW-INDEX              VALUE X'07'.
               78  GET-NEXT-RECORD             VALUE X'08'.
               78  ADD-KEY-VALUE               VALUE X'09'.
               78  UNLOCK-RECORD               VALUE X'0F'.

       01  FCD-AREA.
           COPY xfhfcd.

       01  FILE-NAME                       PIC X(64).
       01  FILE-NAME-LEN                   PIC 9(04) COMP-X.

       01  RECORD-AREA.
           05  PRIME-KEY                   PIC X(25).
           05  DATA-AREA                   PIC X(10).

       01  RECORD-AREA2.
           05  PRIME-KEY2                  PIC X(25).
           05  DATA-AREA2                  PIC X(10).

       01  KEY-DEF-AREA.
           05  GLOBAL-INFORMATION-AREA.
               10  LENGTH-OF-KEY-DEF-AREA  PIC 9(04) COMP-X.
               10  FILLER                  PIC X(04).
               10  NUMBER-OF-KEYS          PIC 9(04) COMP-X.
               10  FILLER                  PIC X(06).
           05  KEY-DEF-AREA-PARAM-BLOCK.
               10  COMPONENT-COUNT         PIC 9(04) COMP-X.
               10  OFFSET-TO-COMPONENT     PIC 9(04) COMP-X.
               10  KEY-FLAGS               PIC 9(02) COMP-X.
               10  KEY-COMPRESSION         PIC 9(02) COMP-X.
               10  SPARSE-CHARACTER        PIC X(01).
               10  FILLER                  PIC X(09).
           05  COMPONENT-DEF-AREA.
               10  FILLER                  PIC X(02).
               10  OFFSET-TO-COMPONENT-DEF PIC 9(09) COMP-X.
               10  COMPONENT-LENGTH        PIC 9(09) COMP-X.


      **************************************************************
       PROCEDURE DIVISION.
      **************************************************************
       0000-MAIN.
           PERFORM 1000-OPEN-FILE.
           PERFORM 2000-READ-RECORD.
           DISPLAY 'AFTER READ ------> ' RECORD-AREA '.'.
           MOVE '1234567890' TO DATA-AREA.
           PERFORM 3000-REWRITE-RECORD.
           PERFORM 2000-READ-RECORD.
           DISPLAY 'AFTER WRITE -----> ' RECORD-AREA '.'.
           MOVE SPACES TO DATA-AREA.
           PERFORM 3000-REWRITE-RECORD.
           PERFORM 5000-CLOSE-FILE.
           PERFORM 1000-OPEN-FILE.
           PERFORM 6000-START.
           PERFORM 7000-READ-PREVIOUS.
           DISPLAY 'AFTER READ PREV -> ' RECORD-AREA2 '.'.
           PERFORM 5000-CLOSE-FILE.

           STOP RUN.
      *
      *--------------------------------*
       1000-Open-File.
      *--------------------------------*
      *
           MOVE 'TEST1EXTFH' TO FILE-NAME
           MOVE 10           TO FILE-NAME-LEN

      *    MOVE LOW-VALUES             TO FCD-AREA
           MOVE FCD--VERSION-NUMBER    TO FCD-VERSION

           MOVE FCD--INDEXED-ORG       TO FCD-ORGANIZATION
           MOVE FILE-NAME-LEN          TO FCD-NAME-LENGTH
           SET  FCD-FILENAME-ADDRESS   TO ADDRESS OF FILE-NAME
           SET  FCD-KEY-DEF-ADDRESS    TO ADDRESS OF KEY-DEF-AREA
           MOVE 16                     TO FCD-FS-FLAGS
           MOVE LENGTH OF RECORD-AREA  TO FCD-CURRENT-REC-LEN
           MOVE 1                      TO NUMBER-OF-KEYS
           MOVE LENGTH OF PRIME-KEY    TO COMPONENT-LENGTH
           MOVE 8                      TO FCD-ACCESS-MODE
           MOVE 0                      TO FCD-LOCK-MODE
           MOVE 128                    TO FCD-OPEN-MODE

           MOVE COBOL-TYPE             TO ACTION-TYPE
           MOVE OPEN-I-O               TO COBOL-OP
           PERFORM 1100-CALL-EXTFH.

      *
      *--------------------------------*
       1100-Call-Extfh.
      *--------------------------------*
      *
           CALL 'EXTFH' USING ACTION-CODE
                              FCD-AREA
           IF FCD-FILE-STATUS NOT = '00'
               MOVE COBOL-OP TO OP-X
               IF FCD-STATUS-KEY-1 = '9'
                   DISPLAY "FILE ERROR, STATUS: 9/" FCD-BINARY
                           " OPCODE: " OP-N
               ELSE
                   DISPLAY "FILE ERROR, STATUS: " FCD-FILE-STATUS
                           " OPCODE: " OP-N
               END-IF
               IF FCD-FILE-STATUS = '23'
                   DISPLAY "Record: " RECORD-AREA "."
               END-IF
               STOP RUN
           END-IF.
      *
      *--------------------------------*
       2000-Read-Record.
      *--------------------------------*
      *
           INITIALIZE RECORD-AREA.

           MOVE 'RECORD-3'           TO PRIME-KEY.

           MOVE READ-RANDOM-LOCK     TO COBOL-OP.
           SET FCD-RECORD-ADDRESS    TO ADDRESS OF RECORD-AREA.
           PERFORM 1100-CALL-EXTFH.
      *
      *--------------------------------*
       3000-Rewrite-Record.
      *--------------------------------*
      *
           MOVE COBOL-TYPE     TO ACTION-TYPE.
           MOVE REWRITE-RECORD TO COBOL-OP.

           PERFORM 1100-CALL-EXTFH.
      *
      *--------------------------------*
       5000-Close-File.
      *--------------------------------*
      *
           MOVE COBOL-TYPE     TO ACTION-TYPE.
           MOVE CLOSE-FILE     TO COBOL-OP.

           PERFORM 1100-CALL-EXTFH.
      *
      *--------------------------------*
       6000-Start.
      *--------------------------------*
      *
           SET FCD-RECORD-ADDRESS     TO ADDRESS OF RECORD-AREA.
           MOVE 25                    TO FCD-KEY-LENGTH.
           MOVE HIGH-VALUES           TO PRIME-KEY.

           MOVE COBOL-TYPE            TO ACTION-TYPE.
           MOVE START-LESS            TO COBOL-OP.

           PERFORM 1100-CALL-EXTFH.
      *
      *--------------------------------*
       7000-Read-Previous.
      *--------------------------------*
      *
           MOVE COBOL-TYPE     TO ACTION-TYPE.
           MOVE READ-PREVIOUS  TO COBOL-OP.
           INITIALIZE RECORD-AREA2.
           SET FCD-RECORD-ADDRESS     TO ADDRESS OF RECORD-AREA2.

           PERFORM 1100-CALL-EXTFH.