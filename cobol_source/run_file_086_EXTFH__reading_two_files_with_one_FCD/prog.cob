IDENTIFICATION          DIVISION.
      ****************************************************************
       PROGRAM-ID.             prog.
      *AUTHOR.                 TOKYO-SYSTEM-HOUSE.
      *DATE-WRITTEN.           2023/02/28.
      ****************************************************************
       ENVIRONMENT             DIVISION.
      ****************************************************************
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
           SELECT  F-SEQ-FILE  ASSIGN          TO    "F-SEQ"
                               ORGANIZATION    IS    SEQUENTIAL
                               FILE STATUS     IS    F-SEQ-STATUS.
           SELECT  F-TXT-FILE  ASSIGN          TO    "F-TXT"
                               ORGANIZATION    IS    LINE SEQUENTIAL
                               FILE STATUS     IS    F-TXT-STATUS.
      ****************************************************************
       DATA                    DIVISION.
      ****************************************************************
       FILE                    SECTION.
       FD  F-SEQ-FILE.
       01  F-SEQ-RECORD.
         03  F-SEQ-DATA        PIC X(5).
       FD  F-TXT-FILE.
       01  F-TXT-RECORD.
         03  F-TXT-DATA        PIC X(10).
       WORKING-STORAGE         SECTION.
       01  F-SEQ-STATUS        PIC X(2).
       01  F-TXT-STATUS        PIC X(2).

       01  OPCODE              PIC X(2).
       78  OP-QUERY-FILE       VALUE X"0006".
       78  OP-OPEN-INPUT       VALUE X"fa00".
       78  OP-OPEN-OUTPUT      VALUE X"fa01".
       78  OP-OPEN-I-O         VALUE X"fa02".
       78  OP-WRITE            VALUE X"faf3".
       78  OP-RELEASE          VALUE X"faf3".
       78  OP-REWRITE          VALUE X"faf4".
       78  OP-READ-NEXT        VALUE X"faf5".
       78  OP-START-EQUAL      VALUE X"fae9".
       78  OP-CLOSE            VALUE X"fa80".

       01  FCD.
           COPY "xfhfcd3.cpy".
       01  EX-FILENAME         PIC X(260).
       01  EX-RECORD-BUFFER    PIC X(32767).
      ****************************************************************
       PROCEDURE               DIVISION.
      ****************************************************************
       MAIN-RTN.
      *    CREATE FILE
           OPEN OUTPUT F-SEQ-FILE.
           MOVE "SEQ01" TO F-SEQ-DATA.
           WRITE F-SEQ-RECORD.
           MOVE "SEQ02" TO F-SEQ-DATA.
           WRITE F-SEQ-RECORD.
           MOVE "SEQ03" TO F-SEQ-DATA.
           WRITE F-SEQ-RECORD.
           MOVE "SEQ04" TO F-SEQ-DATA.
           WRITE F-SEQ-RECORD.
           MOVE "SEQ05" TO F-SEQ-DATA.
           WRITE F-SEQ-RECORD.
           CLOSE F-SEQ-FILE.
           OPEN OUTPUT F-TXT-FILE.
           MOVE "TXTA123456" TO F-TXT-DATA.
           WRITE F-TXT-RECORD.
           MOVE "TXTB123456" TO F-TXT-DATA.
           WRITE F-TXT-RECORD.
           MOVE "TXTC123456" TO F-TXT-DATA.
           WRITE F-TXT-RECORD.
           MOVE "TXTD123456" TO F-TXT-DATA.
           WRITE F-TXT-RECORD.
           CLOSE F-TXT-FILE.

      *    SET FCD
           MOVE LOW-VALUES TO FCD.
           MOVE FCD--VERSION-NUMBER   TO FCD-VERSION.
           SET  FCD-FILENAME-ADDRESS  TO ADDRESS OF EX-FILENAME.
           MOVE 80                    TO FCD-NAME-LENGTH.
           SET FCD-RECORD-ADDRESS     TO ADDRESS OF EX-RECORD-BUFFER.

      *    OPEN first file
           MOVE fcd--sequential-org   TO FCD-ORGANIZATION.
           MOVE "F-SEQ"               TO EX-FILENAME.
           MOVE OP-OPEN-INPUT         TO OPCODE.
           MOVE FCD--DYNAMIC-ACCESS   TO FCD-ACCESS-MODE.
           MOVE 5                     TO FCD-CURRENT-REC-LEN.
           MOVE 5                     TO FCD-MIN-REC-LENGTH.
           MOVE 5                     TO FCD-MAX-REC-LENGTH.
           CALL "EXTFH" USING OPCODE, FCD.
           DISPLAY "OPEN STATUS:"  
                                      FCD-STATUS-KEY-1 "/" FCD-BINARY.

      *    READ RECORD
           MOVE OP-READ-NEXT          TO OPCODE.
           MOVE "00" TO FCD-FILE-STATUS.
           PERFORM UNTIL FCD-STATUS-KEY-1 NOT = "0"
               MOVE SPACE                 TO EX-RECORD-BUFFER
               CALL "EXTFH" USING OPCODE, FCD
               DISPLAY "READ NEXT STATUS:"
                                      FCD-STATUS-KEY-1 "/" FCD-BINARY
               DISPLAY "DATA:" EX-RECORD-BUFFER(1:10) '-'
           END-PERFORM.

      *    CLOSE FILE
           MOVE OP-CLOSE              TO OPCODE.
           CALL "EXTFH" USING OPCODE, FCD.
           DISPLAY "CLOSE STATUS:"  
                                      FCD-STATUS-KEY-1 "/" FCD-BINARY.

      *    OPEN second file
           MOVE fcd--line-sequential-org   TO FCD-ORGANIZATION.
           MOVE "F-TXT"               TO EX-FILENAME.
           MOVE OP-OPEN-INPUT         TO OPCODE.
           MOVE FCD--DYNAMIC-ACCESS   TO FCD-ACCESS-MODE.
           MOVE 10                    TO FCD-CURRENT-REC-LEN.
           MOVE 10                    TO FCD-MIN-REC-LENGTH.
           MOVE 10                    TO FCD-MAX-REC-LENGTH.
           CALL "EXTFH" USING OPCODE, FCD.
           DISPLAY "OPEN STATUS:"  
                                      FCD-STATUS-KEY-1 "/" FCD-BINARY.

      *    READ RECORD
           MOVE OP-READ-NEXT          TO OPCODE.
           MOVE "00" TO FCD-FILE-STATUS.
           PERFORM UNTIL FCD-STATUS-KEY-1 NOT = "0"
               MOVE SPACE                 TO EX-RECORD-BUFFER
               CALL "EXTFH" USING OPCODE, FCD
               DISPLAY "READ NEXT STATUS:"
                                      FCD-STATUS-KEY-1 "/" FCD-BINARY
               DISPLAY "DATA:" EX-RECORD-BUFFER(1:10) '-'
           END-PERFORM.

      *    CLOSE FILE
           MOVE OP-CLOSE              TO OPCODE.
           CALL "EXTFH" USING OPCODE, FCD.
           DISPLAY "CLOSE STATUS:"  
                                      FCD-STATUS-KEY-1 "/" FCD-BINARY.

       MAIN-EXT.
           STOP RUN.