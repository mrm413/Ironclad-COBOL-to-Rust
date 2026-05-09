IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.

       01  I                       PIC XX COMP-X.

       01  WS-FCD-DDNAME           PIC X(8) VALUE SPACES.
       01  WS-FCD-PTR              POINTER   VALUE NULL.

       01  WS-FCD-SIZE             PIC 9(04) VALUE   0       COMP-5.
       01  WS-FCD-FLAGS            PIC 9(04) VALUE   0       COMP-5.

       01  DISPLAY-BYTE.
          05  DISPLAY-XXX             PIC X(03).
          05  DISPLAY-ZZ9             REDEFINES DISPLAY-XXX
                                      PIC ZZ9.
       01  ACTION-CODE                 pic x(2).
          78  OP-OPEN-INPUT           value x"fa00".
          78  OP-OPEN-OUTPUT          value x"fa01".
          78  OP-OPEN-I-O             value x"fa02".
          78  OP-WRITE                value x"faf3".
          78  OP-RELEASE              value x"faf3".
          78  OP-REWRITE              value x"faf4".
          78  OP-READ-NEXT            value x"faf5".
          78  OP-START-EQUAL          value x"fae9".
          78  OP-CLOSE                value x"fa80".
          78  OP-QUERY-FILE           value x"0006".

       01  DISPLAY-A1-XXX              PIC X(03).
       01  DISPLAY-A1-ZZ9              REDEFINES DISPLAY-A1-XXX
                                      PIC ZZ9.
       01  DISPLAY-A2-XXX              PIC X(03).
       01  DISPLAY-A2-ZZ9              REDEFINES DISPLAY-A2-XXX
                                       PIC ZZ9.

       01  FCD-FILENAME               PIC X(80) value "test.out".
       01  FCD-RECORD                 PIC X(512) value spaces.

       LINKAGE SECTION.

       01  FCD-MAP.
           copy 'xfhfcd3.cpy'.

      *================================================================*
       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
       000-MAIN.

          PERFORM 100-OPEN.

          PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
            MOVE I TO DISPLAY-A1-ZZ9
            MOVE DISPLAY-A1-ZZ9 TO FCD-RECORD
            PERFORM 300-WRITE
          END-PERFORM.

          PERFORM 400-CLOSE.
          STOP RUN.

      *----------------------------------------------------------------*
      *    Process the open request
      *
       100-OPEN.

          MOVE "TESTOUT" TO WS-FCD-DDNAME

          MOVE LENGTH OF FCD-MAP TO WS-FCD-SIZE
          DISPLAY "FCD SIZE " WS-FCD-SIZE.

          IF WS-FCD-PTR EQUAL NULL
             ALLOCATE ws-fcd-size characters
                           returning WS-FCD-PTR

             SET  ADDRESS OF FCD-MAP  TO WS-FCD-PTR
             MOVE LOW-VALUES          TO FCD-MAP
             MOVE WS-FCD-SIZE         TO FCD-LENGTH
             move fcd--version-number TO FCD-VERSION
             MOVE "00"                TO FCD-FILE-STATUS
             move fcd--status-defined to FCD-ACCESS-MODE
             move fcd--open-closed    to FCD-OPEN-MODE
             move fcd--external-name  to FCD-OTHER-FLAGS
             SET  FCD-HANDLE          TO NULL
             MOVE 8                   TO FCD-NAME-LENGTH
             SET  FCD-FILENAME-ADDRESS TO ADDRESS
                                       OF WS-FCD-DDNAME
             SET  FCD-KEY-DEF-ADDRESS TO NULL
             move fcd--allow-readers  to FCD-LOCKTYPES
          ELSE
             SET  ADDRESS OF FCD-MAP  TO WS-FCD-PTR
             IF FCD-OPEN-MODE NOT = fcd--open-closed
                DISPLAY "ERRROR - FILE ALREADY OPEN"
                STOP RUN
             END-IF
          END-IF

          move fcd--line-sequential-org to FCD-ORGANIZATION
          move fcd--recmode-fixed       to FCD-RECORDING-MODE
          move 10 to FCD-MIN-REC-LENGTH, FCD-MAX-REC-LENGTH
          SET  FCD-RECORD-ADDRESS     TO ADDRESS OF FCD-RECORD

      * Move fcd--cr-delimiter for CR LF after each record
      *   move fcd--cr-delimiter        to FCD-STATUS-TYPE

          move op-open-output to action-code

          PERFORM 800-CALL-EXTFH
          .

      *----------------------------------------------------------------*
      *    Process the write request
      *
       300-WRITE.

          move 10 to FCD-CURRENT-REC-LEN
          move op-write to action-code
          PERFORM 800-CALL-EXTFH
          .
      *----------------------------------------------------------------*
      *    Process the close request
      *
       400-CLOSE.
          MOVE "00"                   TO FCD-FILE-STATUS
          move op-close               to action-code
          PERFORM 800-CALL-EXTFH
          .
      *----------------------------------------------------------------*
      *    External file handler interface -- all I/O goes through here
      *
        800-CALL-EXTFH.

            CALL "EXTFH" USING ACTION-CODE, FCD-MAP

            IF FCD-STATUS-KEY-1 = "9" AND FCD-BINARY = 199
               MOVE "10" TO FCD-FILE-STATUS
            END-IF
            .