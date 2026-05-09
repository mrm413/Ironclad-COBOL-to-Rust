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

       01  WS-FCD-DDNAME           PIC X(10) VALUE SPACES.
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
      *********************************************
      * FCD2 definition for Callable File Handler *
      *********************************************
           05  FCD-FILE-STATUS.
               10  FCD-STATUS-KEY-1 PIC X.
               10  FCD-STATUS-KEY-2 PIC X.
               10  FCD-BINARY       REDEFINES FCD-STATUS-KEY-2
                                    PIC X COMP-X.
           05  FCD-LENGTH            PIC XX COMP-X.
           05  FCD-VERSION           PIC X COMP-X.
              78 FCD-VERSION-NUMBER           VALUE 0.

           05  FCD-ORGANIZATION     PIC 9(2) COMP-X.
             78 fcd--line-sequential-org      value 0.
             78 fcd--sequential-org           value 1.
             78 fcd--indexed-org              value 2.
             78 fcd--relative-org             value 3.
             78 fcd--determine-org            value 255. *> see opcode 0006
           05  FCD-ACCESS-MODE      PIC 9(2) COMP-X.
             78 fcd--sequential-access        value 0.
             78 fcd--dup-prime-access         value 1.
             78 fcd--random-access            value 4.
             78 fcd--dynamic-access           value 8.
             78 fcd--status-defined           value h"80".
           05  FCD-OPEN-MODE        PIC 9(2) COMP-X.
             78 fcd--open-input               value 0.
             78 fcd--open-output              value 1.
             78 fcd--open-i-o                 value 2.
             78 fcd--open-extend              value 3.
             78 fcd--open-max                 value 3.
             78 fcd--open-closed              value 128.
           05  FILLER               PIC X(2).
           05  FCD-BLOCK-SIZE       PIC 9(2) COMP-X.
           05  FCD-NAME-LENGTH      PIC 9(4) COMP-X.
           05  FCD-RELADDR-BIG      PIC X(8) COMP-X.
           05  FILLER               PIC X.
           05  FCD-TRANS-LOG        PIC 9(2) COMP-X.
           05  FILLER               PIC X(1).
           05  FCD-LOCK-MODE        PIC 9(2) COMP-X.
             78 fcd--multilock-bit            value h"80".
             78 fcd--writelock-bit            value h"40".
             78 fcd--retry-open-bit           value h"20".
             78 fcd--skip-lock-bit            value h"10".
             78 fcd--retry-lock-bit           value h"08".
             78 fcd--manual-lock-bit          value h"04".
             78 fcd--auto-lock-bit            value h"02".
             78 fcd--exclusive-bit            value h"01".
             78 fcd--sharing-bits
             value fcd--manual-lock-bit + fcd--auto-lock-bit.
           05  FCD-OTHER-FLAGS      PIC 9(2) COMP-X.
             78 fcd--optional-file            value h"80".
             78 fcd--nodetectlock-input       value h"40".
             78 fcd--not-optional             value h"20".
             78 fcd--external-name            value h"10".
             78 fcd--get-info                 value h"08".
             78 fcd--nodetectlock             value h"04".
             78 fcd--multiple-reel            value h"02".
             78 fcd--line-advancing           value h"01".
             78 fcd--special-sequential
             value fcd--optional-file
             + fcd--multiple-reel + fcd--line-advancing.
           05  FILLER               PIC X(2).
           05  FCD-HANDLE           USAGE POINTER.
           05  FCD-PERCENT          PIC 9(2) COMP-X.
           05  FCD-REC-COUNT-SET    REDEFINES FCD-PERCENT
                                    PIC 9(2) COMP-X.
           05  FCD-STATUS-TYPE      PIC 9(2) COMP-X.
           05  FCD-FILE-FORMAT      PIC 9(2) COMP-X.
           05  FILLER               PIC X(3).
           05  FCD-MAX-REC-LENGTH   PIC XX   COMP-X.
           05  FILLER               PIC X(2).
           05  FCD-MVS-FLAGS        PIC 9(2) COMP-X.
           05  FCD-RELATIVE-KEY     PIC 9(9) COMP-X.
           05  FCD-RECORDING-MODE   PIC 9(2) COMP-X.
               78 fcd--recmode-fixed            value 0.
               78 fcd--recmode-variable         value 1.
           05  FCD-CURRENT-REC-LEN  PIC XX   COMP-X.
           05  FCD-MIN-REC-LENGTH   PIC XX   COMP-X.
           05  FCD-KEY-ID           PIC 9(4) COMP-X.
           05  FCD-LINE-COUNT       REDEFINES FCD-KEY-ID
                                    PIC 9(4) COMP-X.
           05                       REDEFINES FCD-KEY-ID.
               10  FCD-USE-FILES    PIC X COMP-X.
               10  FCD-GIVE-FILES   PIC X COMP-X.
           05  FCD-KEY-LENGTH       PIC 9(4) COMP-X.
           05  FCD-RECORD-ADDRESS   USAGE POINTER.
           05  FCD-FILENAME-ADDRESS USAGE POINTER.
           05  FCD-KEY-DEF-ADDRESS  USAGE POINTER.
           05  FCD-COL-SEQ-ADDRESS  USAGE POINTER.
           05  FCD-RELADDR-OFFSET   PIC 9(9) COMP-X.
           05  FCD-RELADDR          REDEFINES FCD-RELADDR-OFFSET
                                    PIC 9(9) COMP-X.
           05  FCD-FILDEF-ADDRESS   REDEFINES FCD-RELADDR-OFFSET
                                    USAGE POINTER.
           05  FCD-NLS-ID           PIC 9(4) COMP-X.
           05  FCD-DATA-COMPRESS    PIC 9(2) COMP-X.
           05  FCD-SESSION-ID       PIC 9(9) COMP-X.
           05  FCD-FS-FILE-ID       PIC 9(4) COMP-X.
           05  FCD-MAX-REL-KEY      PIC 9(9) COMP-X.
           05  FCD-FLAGS-1          PIC 99   COMP-X.
           05  FCD-BLOCKING         PIC 99   COMP-X.
           05  FCD-ADDITIONAL-STATUS REDEFINES FCD-BLOCKING
                                    PIC X    COMP-X.
           05  FCD-LOCKTYPES        PIC 99   COMP-X.
             78 fcd--interlang-locking        value h"80".
             78 fcd--allow-readers            value h"40".
             78 fcd--separate-lock-file       value h"20".
             78 fcd--single-open              value h"10".
             78 fcd--nfs-file-lock            value h"08".
             78 fcd--nfs-file-lock-hp         value h"04".
             78 fcd--nfs-file-locks
             value fcd--nfs-file-lock + fcd--nfs-file-lock-hp.
           05  FCD-FS-FLAGS         PIC 99   COMP-X.
           05  FCD-CONFIG-FLAGS     PIC 99   COMP-X.
           05  FCD-MISC-FLAGS       PIC 99   COMP-X.
           05  FCD-CONFIG-FLAGS2    PIC 99   COMP-X.
           05  FCD-IDXCACHE-SIZE    PIC 99   COMP-X.
           05  FCD-IDXCACHE-BUFFS   PIC 99   COMP-X.
           05  FCD-INTERNAL-FLAGS-1   PIC X COMP-X.
           05  FCD-INTERNAL-FLAGS-2   PIC X COMP-X.

      *================================================================*
       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
       000-MAIN.

          PERFORM 100-OPEN.

          PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
            MOVE I TO DISPLAY-A1-ZZ9
            MOVE DISPLAY-A1-ZZ9 TO FCD-RECORD
            MOVE 10 TO FCD-CURRENT-REC-LEN
            IF I = 3 OR 5
                MOVE "Have a great day" TO FCD-RECORD (5:20)
                MOVE 25 TO FCD-CURRENT-REC-LEN
            END-IF
            IF I = 8
                MOVE "Enjoy the show" TO FCD-RECORD (5:20)
                MOVE 19 TO FCD-CURRENT-REC-LEN
            END-IF
            PERFORM 300-WRITE
          END-PERFORM.

          PERFORM 400-CLOSE.

          MOVE OP-OPEN-INPUT TO ACTION-CODE
          PERFORM 800-CALL-EXTFH
          DISPLAY "Listing " WS-FCD-DDNAME '.'.
          PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
            PERFORM 350-READ
            DISPLAY FCD-CURRENT-REC-LEN ": "
                    FCD-RECORD (1:FCD-CURRENT-REC-LEN) " :"
          END-PERFORM.
          PERFORM 400-CLOSE.
          STOP RUN.

      *----------------------------------------------------------------*
      *    Process the open request
      *
       100-OPEN.

          MOVE "TESTOUT" TO WS-FCD-DDNAME

          MOVE LENGTH OF FCD-MAP TO WS-FCD-SIZE
          DISPLAY "FCD SIZE " WS-FCD-SIZE '.'.
          DISPLAY "Writing " WS-FCD-DDNAME '.'.

          IF WS-FCD-PTR EQUAL NULL
             ALLOCATE ws-fcd-size CHARACTERS
                           returning WS-FCD-PTR

             SET  ADDRESS OF FCD-MAP  TO WS-FCD-PTR
             MOVE LOW-VALUES          TO FCD-MAP
             MOVE WS-FCD-SIZE         TO FCD-LENGTH
             MOVE FCD-VERSION-NUMBER  TO FCD-VERSION
             MOVE "00"                TO FCD-FILE-STATUS
             MOVE FCD--STATUS-DEFINED TO FCD-ACCESS-MODE
             MOVE FCD--OPEN-CLOSED    TO FCD-OPEN-MODE
             MOVE FCD--EXTERNAL-NAME  TO FCD-OTHER-FLAGS
             SET  FCD-HANDLE          TO NULL
             MOVE 8                   TO FCD-NAME-LENGTH
             SET  FCD-FILENAME-ADDRESS TO ADDRESS
                                       OF WS-FCD-DDNAME
             SET  FCD-KEY-DEF-ADDRESS TO NULL
             MOVE FCD--ALLOW-READERS  TO FCD-LOCKTYPES
          ELSE
             SET  ADDRESS OF FCD-MAP  TO WS-FCD-PTR
             IF FCD-OPEN-MODE NOT = fcd--open-closed
                DISPLAY "ERRROR - FILE ALREADY OPEN"
                STOP RUN
             END-IF
          END-IF

          MOVE FCD--LINE-SEQUENTIAL-ORG TO FCD-ORGANIZATION
          MOVE FCD--RECMODE-FIXED       TO FCD-RECORDING-MODE
          MOVE 10 TO FCD-MIN-REC-LENGTH
          MOVE 50 TO FCD-MAX-REC-LENGTH

      *  Check for missing record address
      *   MOVE OP-OPEN-OUTPUT TO ACTION-CODE
      *   PERFORM 800-CALL-EXTFH

          SET  FCD-RECORD-ADDRESS    TO ADDRESS OF FCD-RECORD
          SET  FCD-FILENAME-ADDRESS  TO NULL
      *  Check for missing filename address
          MOVE OP-OPEN-OUTPUT TO ACTION-CODE
          PERFORM 800-CALL-EXTFH

      *  Now set record address
          SET  FCD-RECORD-ADDRESS    TO ADDRESS OF FCD-RECORD
          SET  FCD-FILENAME-ADDRESS  TO ADDRESS OF WS-FCD-DDNAME
          MOVE OP-OPEN-OUTPUT TO ACTION-CODE
          PERFORM 800-CALL-EXTFH
          .

      *----------------------------------------------------------------*
      *    Process the write request
      *----------------------------------------------------------------*
       300-WRITE.
          MOVE OP-WRITE TO ACTION-CODE
          PERFORM 800-CALL-EXTFH
          .

      *----------------------------------------------------------------*
      *    Process the read request
      *----------------------------------------------------------------*
       350-READ.
          MOVE OP-READ-NEXT TO ACTION-CODE
          PERFORM 800-CALL-EXTFH
          .

      *----------------------------------------------------------------*
      *    Process the close request
      *----------------------------------------------------------------*
       400-CLOSE.
          MOVE OP-CLOSE               TO ACTION-CODE
          PERFORM 800-CALL-EXTFH
          .
      *----------------------------------------------------------------*
      *    External file handler interface -- all I/O goes through here
      *
        800-CALL-EXTFH.

           MOVE "00"                   TO FCD-FILE-STATUS
           CALL "EXTFH" USING ACTION-CODE, FCD-MAP

           IF FCD-STATUS-KEY-1 NOT = "0"
               IF FCD-STATUS-KEY-1 = "9"
                  IF FCD-BINARY = 161
                      DISPLAY "EXTFH Status: 9/" FCD-BINARY
                      DISPLAY "FCD2 is not accepted!"
                      STOP RUN
                  END-IF
                  DISPLAY "EXTFH Status: 9/" FCD-BINARY
                  IF FCD-BINARY = 141
                      DISPLAY "FCD2 is missing value(s)!"
                  END-IF
               ELSE
                  DISPLAY "EXTFH Status: " FCD-FILE-STATUS
               END-IF
            END-IF
            IF FCD-STATUS-KEY-1 = "9" AND FCD-BINARY = 199
               MOVE "10" TO FCD-FILE-STATUS
            END-IF
            .