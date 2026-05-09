IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FLATFILE
           ASSIGN TO THE-FILE-NAME
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS IS FLAT-STAT.

       DATA  DIVISION.
       FILE SECTION.
       FD  FLATFILE.
       01  FLAT-RECORD.
           10  FILE-NAME                       PICTURE X(8).
           10  FLAT-MARK                       PICTURE X(6).
           10  FLAT-RECNUM                     PICTURE X(6).
           10  FLAT-NUM                        PICTURE Z9.
           10  FLAT-FILLER                     PICTURE X(2).

       WORKING-STORAGE SECTION.
       77  REC-NUM           VALUE  0          BINARY-SHORT UNSIGNED.
       78  MAX-REC           VALUE  3.
       77  FLAT-STAT                           PICTURE X(2).
       77  THE-FILE-NAME                       PICTURE X(48).

       PROCEDURE DIVISION.
           MOVE "file1" TO THE-FILE-NAME
           PERFORM LOADFILE.

           MOVE "file2" TO THE-FILE-NAME
           PERFORM LOADFILE.

           MOVE "file3" TO THE-FILE-NAME
           PERFORM LOADFILE.

           MOVE "file1+file2+file3" TO THE-FILE-NAME
           PERFORM UPDTFILE.

           SET ENVIRONMENT "COB_SEQ_CONCAT_SEP" TO "&"
           MOVE "file1&file2&file3" TO THE-FILE-NAME
           PERFORM LISTFILE.
           STOP RUN RETURNING 0.

       LISTFILE.
           OPEN INPUT FLATFILE.
           IF FLAT-STAT NOT = "00"
               DISPLAY "OPEN INPUT: " THE-FILE-NAME " Sts:" FLAT-STAT
           END-IF.
           PERFORM UNTIL FLAT-STAT NOT = "00"
               PERFORM READ-RECORD
           END-PERFORM.
           CLOSE FLATFILE.

       UPDTFILE.
           OPEN I-O FLATFILE.
           IF FLAT-STAT NOT = "00"
               DISPLAY "OPEN I-O: " THE-FILE-NAME " Sts:" FLAT-STAT
           END-IF.
           PERFORM VARYING REC-NUM FROM 1 BY 1
                      UNTIL FLAT-STAT NOT = "00"
               MOVE SPACES          TO FLAT-RECORD
               READ FLATFILE
               IF REC-NUM = 5
                  MOVE "Hello" TO FLAT-MARK
                  REWRITE FLAT-RECORD
                  IF FLAT-STAT NOT = "00"
                     DISPLAY "REWRITE5: " THE-FILE-NAME "Sts:" FLAT-STAT
                  END-IF
               END-IF
               IF REC-NUM = 7
                  MOVE "$$" TO FLAT-FILLER
                  REWRITE FLAT-RECORD
                  IF FLAT-STAT NOT = "44"
      *  Cannot change size of LINE SEQ record
                     DISPLAY "REWRITE7: " THE-FILE-NAME "Sts:" FLAT-STAT
                  END-IF
               END-IF
           END-PERFORM.
           CLOSE FLATFILE.

       READ-RECORD.
      *    MOVE SPACES                       TO FLAT-RECORD.
           READ FLATFILE
           IF FLAT-STAT NOT = "00"
               IF FLAT-STAT NOT = "10"
                   DISPLAY "Read Status: " FLAT-STAT
               END-IF
           ELSE
               DISPLAY FLAT-RECORD "."
           END-IF.

       LOADFILE.
           OPEN OUTPUT FLATFILE.
           IF FLAT-STAT NOT = "00"
               DISPLAY "OPEN OUTPUT: " THE-FILE-NAME " Sts:" FLAT-STAT
           END-IF.
           PERFORM LOAD-RECORD VARYING REC-NUM FROM 1 BY 1
                                 UNTIL REC-NUM > MAX-REC.
           CLOSE FLATFILE.

       LOAD-RECORD.
           MOVE SPACES                       TO FLAT-RECORD.
           MOVE "Record"                     TO FLAT-RECNUM.
           MOVE THE-FILE-NAME                TO FILE-NAME.
           MOVE REC-NUM                      TO FLAT-NUM.
           WRITE FLAT-RECORD.
           IF FLAT-STAT NOT = "00"
               DISPLAY "Write: " FILE-NAME " Rec#" REC-NUM
                       " Sts:" FLAT-STAT
           END-IF.