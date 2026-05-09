IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FLATFILE
           ASSIGN "SEQODO"
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS IS CUST-STAT .

       DATA  DIVISION.
       FILE SECTION.
       FD  FLATFILE
           BLOCK CONTAINS 5 RECORDS.

       01  TSTREC.
         05  SEQ           PIC 99.
         05  DEP-X         PIC 99.
         05  DEP-Y         PIC 99.
         05  HELLO         PIC X(5) VALUE 'World'.
         05  TSTGRP.
           10  TSTGRP1.
             15  TSTX OCCURS 1 TO 3 TIMES
                      DEPENDING ON DEP-X.
               20  TSTG-1  PIC Z9.
             15  TSTTAIL1  PIC XXXX.
           10  TSTY-ALL.
             15  TSTY OCCURS 1 TO 3 TIMES
                      DEPENDING ON DEP-X.
               20  TSTY-1  PIC 99.
               20  TSTY-2  PIC XXX.
               20  TSTY-3  PIC X
                             OCCURS 1 TO 12 TIMES
                             DEPENDING ON DEP-Y.
               20  TSTY-4  PIC XX.
               20  TSTY-5    OCCURS 1 TO 3 TIMES
                             DEPENDING ON DEP-X.
                  25  TSTY-6 OCCURS 1 TO 3 TIMES
                             DEPENDING ON DEP-X.
                     30  TSTY-7  PIC X.
           10  TSTTAIL2    PIC XX.

       WORKING-STORAGE SECTION.
       77  CUST-STAT PIC  X(2).
       01  LN        PIC  9(3).
       01  IX        PIC  9(9) BINARY.
       01  IY        PIC  9(9) BINARY.
       01  IZ        PIC  9(9) BINARY.
       01  TSTXXX    PIC  X(26) VALUE "Abcdefghijklmnopqrstuvwxyz".
       01  TSTALPHA REDEFINES TSTXXX.
           05 ALPH-CHR PIC  X OCCURS 26 TIMES.
       01  TSTHEX    PIC  X(15) VALUE "123456789ABCDEF".
       01  FILLER REDEFINES TSTHEX.
           05 HEX-CHR PIC  X OCCURS 15 TIMES.

       01  TSTREC2.
         05  DEP-X2        PIC 99.
         05  TSTGRP2.
             10  TSTX2 OCCURS 1 TO 3 TIMES DEPENDING ON DEP-X2.
               15  TSTG2-1  PIC Z9.
             10  TST2TAIL1  PIC XXX.

       01  TSTREC3.
         05  DEP-X3        PIC 99.
         05  TSTGRP3.
             10  TSTX3 OCCURS 1 TO 6 TIMES DEPENDING ON DEP-X3.
               15  TSTG3-1  PIC 9.
       01  TSTWRK   PIC X(24).

       PROCEDURE DIVISION.
       MAIN-10.
           MOVE 6 TO DEP-X3.
           MOVE 1 TO TSTG3-1 (1).
           MOVE 2 TO TSTG3-1 (2).
           MOVE 3 TO TSTG3-1 (3).
           MOVE 4 TO TSTG3-1 (4).
           MOVE 5 TO TSTG3-1 (5).
           MOVE 6 TO TSTG3-1 (6).
           MOVE 3 TO DEP-X3.
           STRING TSTGRP3 "-TRAILER" DELIMITED BY SIZE
           INTO TSTWRK.
           DISPLAY "'" TSTWRK "'".
           OPEN OUTPUT FLATFILE.
           MOVE "Howdy" TO HELLO.
           MOVE 0 TO SEQ.
           MOVE 2 TO DEP-X.
           MOVE 5 TO DEP-Y.
           PERFORM WRITE-REC.
           MOVE 1 TO DEP-X.
           MOVE 2 TO DEP-Y.
           PERFORM WRITE-REC.
           MOVE 3 TO DEP-X.
           MOVE 3 TO DEP-Y.
           PERFORM WRITE-REC.
           MOVE 3 TO DEP-X.
           MOVE 10 TO DEP-Y.
           PERFORM WRITE-REC.
           CLOSE FLATFILE.
           OPEN INPUT FLATFILE.
           PERFORM READ-REC.
           CLOSE FLATFILE.
           STOP RUN.

       WRITE-REC SECTION.
           ADD 1 TO SEQ.
           MOVE LENGTH OF TSTREC TO LN.
           DISPLAY "Write SEQ " SEQ ", DEP-X = " DEP-X
                   " & DEP-Y = " DEP-Y
                   ", TSTREC len:" LN.
           MOVE ALL "*" TO TSTGRP.
           MOVE "<>"    TO TSTTAIL1, TSTTAIL2.
           PERFORM VARYING IX FROM 1 BY 1
                     UNTIL IX > DEP-X
               MOVE IX TO TSTG-1 (IX)
           END-PERFORM.
           MOVE LENGTH OF TSTGRP1 TO LN.
           DISPLAY "Group1: '" TSTGRP1 "' len:" LN.
           PERFORM VARYING IX FROM 1 BY 1
                     UNTIL IX > DEP-X
               MOVE IX TO TSTY-1 (IX)
               MOVE "." TO TSTY-4 (IX)
               PERFORM VARYING IY FROM 1 BY 1
                         UNTIL IY > DEP-Y
                   MOVE ALPH-CHR (IY) TO TSTY-3 (IX, IY)
               END-PERFORM
           END-PERFORM.
           PERFORM VARYING IX FROM 1 BY 1
                     UNTIL IX > DEP-X
               PERFORM VARYING IY FROM 1 BY 1
                         UNTIL IY > DEP-X
                 PERFORM VARYING IZ FROM 1 BY 1
                           UNTIL IZ > DEP-X
                   MOVE HEX-CHR (IX+IY+IZ) TO TSTY-7 (IX, IY, IZ)
                 END-PERFORM
               END-PERFORM
           END-PERFORM.
           DISPLAY "  Data: '" TSTGRP "'".

           MOVE ALL "*" TO TSTGRP2.
           MOVE DEP-X TO DEP-X2.
           PERFORM VARYING IX FROM 1 BY 1
                     UNTIL IX > DEP-X2
               MOVE IX TO TSTG2-1 (IX)
           END-PERFORM.
           MOVE "<>"    TO TST2TAIL1.
           MOVE LENGTH OF TSTGRP2 TO LN.
           DISPLAY "Group2: '" TSTGRP2 "' len:" LN.
           WRITE TSTREC.

       READ-REC SECTION.
       READ-10.
           READ FLATFILE AT END GO TO READ-99.
           MOVE LENGTH OF TSTREC TO LN.
           DISPLAY "Read SEQ " SEQ ", DEP-X = " DEP-X
                   " & DEP-Y = " DEP-Y
                   ", TSTREC len:" LN.
           DISPLAY "  Data: '" TSTGRP "'".
           GO TO READ-10.
       READ-99.
           EXIT .