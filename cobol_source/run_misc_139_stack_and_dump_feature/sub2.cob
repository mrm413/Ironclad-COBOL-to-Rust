IDENTIFICATION DIVISION.
       PROGRAM-ID. sub2.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ZRO PIC 9(9) BINARY VALUE 0.
       01  HEXV PIC X  COMP-X.
       01  HEXC REDEFINES HEXV PIC X.

       01  IDX PIC 9(9) BINARY VALUE 0.
       01  TSTREC.
         05  TSTDEP  PIC XXX.
         05  TSTX OCCURS 4 TIMES.
           15  TSTG-1 PIC 99.
           15  TSTX-2 PIC XX OCCURS 4 TIMES.
         05  TSTTAIL1  PIC 99.
         05  TSTCOMP3  PIC 9(5) COMP-3.
         05  TSTLONG   PIC X(100).
         05  TSTHEX    PIC X(100).
         05  TSTHEX2   PIC X(60).
         05  TSTTAILX  PIC X(80).

       01  BASED-RECORD BASED.
           10  B-NUM              PICTURE 9(4) VALUE 123.
           10  B-DISK             PICTURE X(8) VALUE "marvdisc".
           10  B-NO-TERMINALS     PICTURE 9(4).
       77  BASED-NEVER-SET        PIC     X    BASED.

       LINKAGE SECTION.
       01  X  PIC 9(9) BINARY.
       01  TSPFL-RECORD.
           10  CM-CUST-NUM        PICTURE X(8).
           10  CM-COMPANY         PICTURE X(25).
           10  CM-DISK            PICTURE X(8).
           10  CM-NO-TERMINALS    PICTURE 9(4).
       77  DYNAMIC-NUM            PICTURE 9(4).

       PROCEDURE DIVISION USING X, TSPFL-RECORD.
       SubwaY SECTION.
           IF ADDRESS OF BASED-RECORD = NULL
              ALLOCATE BASED-RECORD INITIALIZED
           ELSE
              SET ADDRESS OF DYNAMIC-NUM TO ADDRESS OF BASED-RECORD
              ADD 1 TO B-NUM
           END-IF.
       DO-CALL.
           IF X = 5440
               CALL "sub1" USING X, OMITTED.
           MOVE ALL "X" TO TSTREC.
           MOVE 1 TO TSTG-1 (1).
           MOVE 2 TO TSTG-1 (2).
           MOVE 3 TO TSTG-1 (3).
           MOVE 'A' TO TSTX-2 (1,1).
           MOVE 'B' TO TSTX-2 (2,1).
           MOVE 'C' TO TSTX-2 (3,1).
           MOVE 'xx' TO TSTX-2 (1,4).
           MOVE 'yy' TO TSTX-2 (2,4).
           MOVE 'zz' TO TSTX-2 (3,4).
           MOVE SPACES TO TSTX-2 (1,3).
           MOVE HIGH-VALUES TO TSTX (4).
           MOVE LOW-VALUES TO TSTX-2 (2,3).
           MOVE HIGH-VALUES TO TSTX-2 (3,3).
           MOVE "Quick brown fox jumped over the dog"
             TO TSTLONG, TSTLONG (50:36).
           MOVE "Quicker grey fox jumped the cougar"
             TO TSTHEX (1:35).
           MOVE 17 TO HEXV.
           MOVE HEXC TO TSTHEX (39:1).
           MOVE HEXC TO TSTTAIL1 (2:1).
           MOVE 7 TO HEXV.
           MOVE HEXC TO TSTHEX (47:1).
           MOVE 13 TO HEXV.
           MOVE HEXC TO TSTHEX (59:1).
           MOVE 0 TO HEXV.
           MOVE HEXC TO TSTHEX2 (39:1), TSTHEX2 (10:1).
           MOVE 9 TO HEXV.
           MOVE HEXC TO TSTHEX2 (47:1).
           MOVE '\' TO TSTHEX2 (32:1).
           MOVE 13 TO HEXV.
           MOVE HEXC TO TSTHEX2 (59:1).
           MOVE 'A' TO TSTHEX2 (54:1).
           MOVE LOW-VALUES TO TSTTAILX.
      *
           COPY cpyabrt.
       END PROGRAM sub2.