IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
           SOURCE-COMPUTER. mine WITH DEBUGGING MODE.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MY-DATA-FIELDS.
           02  MY-DATA-FIELD-1  PIC 9 VALUE 1.
           02  MDF.
             03 MDF-TOO-LONG-NAMES.
               05  MY-DATA-FIELD-2  PIC 9 VALUE 4.
               05  MY-DATA-FIELD-3  REDEFINES MY-DATA-FIELD-2 PIC X.
       01  MY-DATA-FIELD-B  PIC X(40) VALUE "ABCD".
       PROCEDURE        DIVISION.
       DECLARATIVES.
       TEST-DEBUG SECTION.
           USE FOR DEBUGGING ON ALL REFERENCES OF MY-DATA-FIELD-1
                                ALL               MY-DATA-FIELD-2
                                MY-DATA-FIELD-3 MY-DATA-FIELD-B.
           DISPLAY DEBUG-ITEM "|" END-DISPLAY.
       END DECLARATIVES.
       INIT-PAR.
           MOVE 6 TO MY-DATA-FIELD-2.
       FIRST-PAR.
           PERFORM VARYING MY-DATA-FIELD-1 FROM 1 BY 1
                   UNTIL   MY-DATA-FIELD-1 > MY-DATA-FIELD-2
              *> empty by design
           END-PERFORM.
       END-PAR.
           MOVE "99" TO MY-DATA-FIELD-B.
           MOVE MY-DATA-FIELD-B TO MY-DATA-FIELDS.
           MOVE "X"  TO MY-DATA-FIELD-3
                     OF MDF
                     OF MY-DATA-FIELDS.
           MOVE "-"  TO MY-DATA-FIELD-3
                     OF MDF-TOO-LONG-NAMES
                     OF MDF
                     OF MY-DATA-FIELDS.
           STOP RUN.