IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77  I                               PIC 9(04) COMP-5.
       77  FILE-NAME                       PIC X(64).
       77  FILE-NAME-LEN                   PIC 9(04) COMP-X.
       01  FH-ACTION                       PIC X(02).
       01  FILLER REDEFINES FH-ACTION.
           05            PIC X COMP-X.
           05 FH-ACTION2 PIC X COMP-X.
       01  ACTION-CODE REDEFINES FH-ACTION.
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

       01  RECORD-AREA.
           05  PRIME-KEY                   PIC X(20).
           05  DATA-AREA1                  PIC 9(10).
           05  RECORD-GROWTH               PIC X(50).

       PROCEDURE DIVISION.
       A-000-MAIN.
           MOVE X'FA01' TO FH-ACTION
           PERFORM A-100-OPEN-FILE.
           MOVE SPACES  TO RECORD-AREA
           MOVE 0 TO DATA-AREA1
           PERFORM 7 TIMES
               ADD 1  TO DATA-AREA1
               MOVE DATA-AREA1 TO FCD-RELATIVE-KEY
               MOVE 'RECORD-1'           TO PRIME-KEY
               MOVE DATA-AREA1 (10:1)    TO PRIME-KEY (8:1)
               MOVE X'FAF3'              TO FH-ACTION
               SET FCD-RECORD-ADDRESS    TO ADDRESS OF RECORD-AREA
               PERFORM A-200-CALL-EXTFH
           END-PERFORM.
           PERFORM A-600-CLOSE-FILE.

           MOVE X'FA02' TO FH-ACTION
           PERFORM A-100-OPEN-FILE.
           MOVE 3 TO FCD-RELATIVE-KEY
           PERFORM A-700-UPDATE.
           MOVE 6 TO FCD-RELATIVE-KEY
           PERFORM A-700-UPDATE.
           PERFORM A-600-CLOSE-FILE.
           STOP RUN.

       A-100-Open-File.
           MOVE LOW-VALUES TO FCD-AREA
           MOVE FCD--VERSION-NUMBER TO FCD-VERSION
           MOVE 'TESTREL.DAT' TO FILE-NAME
           MOVE 11 TO FILE-NAME-LEN
           MOVE FILE-NAME-LEN TO FCD-NAME-LENGTH
      **   ACCESS SEQ(0) RANDOM(4) DYNAMIC(8)
           MOVE 8 TO FCD-ACCESS-MODE
      **   ISAM(2) RELATIVE(3) LSEQ(0) SEQ(1)
           MOVE 3 TO FCD-ORGANIZATION
      **   CLOSED(128) INPUT(0) OUTPUT(1) I-O(2) EXTEND(3)
           MOVE 128 TO FCD-OPEN-MODE
      **   FIXED(0) OR VARIABLE(1)
           MOVE 0 TO FCD-RECORDING-MODE
           SET FCD-FILENAME-ADDRESS TO ADDRESS OF FILE-NAME
           MOVE LENGTH OF RECORD-AREA TO FCD-MIN-REC-LENGTH
           MOVE LENGTH OF RECORD-AREA TO FCD-MAX-REC-LENGTH
           MOVE LENGTH OF RECORD-AREA TO FCD-CURRENT-REC-LEN
           PERFORM A-200-CALL-EXTFH.

       A-200-Call-Extfh.
           CALL 'EXTFH' USING FH-ACTION
                              FCD-AREA
           IF FCD-FILE-STATUS NOT = '00' AND NOT = '02'
               IF FCD-STATUS-KEY-1 = '9'
                   DISPLAY "Operation: " FH-ACTION2
                           " FILE ERROR, STATUS: 9/" FCD-BINARY
               ELSE
                   DISPLAY "Operation: " FH-ACTION2
                           " FILE ERROR, STATUS: " FCD-FILE-STATUS
               END-IF
               STOP RUN
           END-IF.
       A-300-READ-RECORD.
           INITIALIZE RECORD-AREA.
           MOVE READ-RANDOM-LOCK     TO COBOL-OP.
           SET FCD-RECORD-ADDRESS    TO ADDRESS OF RECORD-AREA.
           PERFORM A-200-CALL-EXTFH.
           MOVE FCD-RELATIVE-KEY TO I.
       A-400-REWRITE-RECORD.
           MOVE COBOL-TYPE     TO ACTION-TYPE.
           MOVE REWRITE-RECORD TO COBOL-OP.
           PERFORM A-200-CALL-EXTFH.
       A-600-CLOSE-FILE.
           MOVE X'FA80' TO FH-ACTION.
           PERFORM A-200-CALL-EXTFH.
       A-700-UPDATE.
           PERFORM A-300-READ-RECORD.
           DISPLAY 'READ    ' I ': ' RECORD-AREA (1:41) '.'.
           MOVE '1234567890' TO RECORD-GROWTH.
           PERFORM A-400-REWRITE-RECORD.
           PERFORM A-300-READ-RECORD.
           DISPLAY 'REWRITE ' I ': ' RECORD-AREA (1:41) '.'.