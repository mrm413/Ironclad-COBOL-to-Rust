IDENTIFICATION DIVISION.
       PROGRAM-ID.  prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT file1 ASSIGN DISK.

       DATA DIVISION.
       FILE SECTION.
       FD  file1.
       01  file1-rec.
           02  file1-serial-1 PIC 9(6).
           02  file1-xseen PIC 9(4).
           02  file1-serial-2 PIC 9(6).

       WORKING-STORAGE SECTION.
       01  w-count PIC 9(6) VALUE 0.
       01  w-eof PIC 9 VALUE 0.
           88  eof VALUE 1 FALSE 0.
       01  w-abort PIC 9 VALUE 0.
           88  abort VALUE 1 FALSE 0.

       PROCEDURE DIVISION.
           OPEN OUTPUT file1
           PERFORM VARYING w-count FROM 1 BY 1
                   UNTIL w-count > 20
               MOVE w-count TO file1-serial-1
               MOVE 0 TO file1-xseen
               ADD 100 w-count GIVING file1-serial-2
               WRITE file1-rec
           END-PERFORM
           CLOSE file1

           OPEN I-O file1
           SET eof TO FALSE
           PERFORM VARYING w-count FROM 1 BY 1
                   UNTIL eof OR abort
               READ file1
                   AT END
                       SET eof TO TRUE

                   NOT AT END
                       IF (file1-serial-1 <> w-count)
                           DISPLAY "FAIL 1: " w-count " :: "
                               file1-serial-1
                           SET abort TO TRUE
                       ELSE IF (file1-serial-2 <> (100 + w-count))
                           DISPLAY "FAIL 2: " w-count " :: "
                               file1-serial-2
                           SET abort TO TRUE
                       ELSE IF (file1-xseen <> 0)
                           DISPLAY "FAIL 3: " w-count " :: " file1-xseen
                           SET abort TO TRUE
                       ELSE IF (w-count = 5 OR 10 OR 15 OR 20)
                           ADD 1000 w-count GIVING file1-serial-2
                           ADD 1 TO file1-xseen
                           REWRITE file1-rec
                       END-IF
               END-READ
           END-PERFORM
           IF NOT ((w-count = 22) AND eof)
               DISPLAY "FAIL 4"
           END-IF
           CLOSE file1

           OPEN INPUT file1
           SET eof TO FALSE
           SET abort TO FALSE
           PERFORM VARYING w-count FROM 1 BY 1
                   UNTIL eof OR abort
               READ file1
                   AT END
                       SET eof TO TRUE

                   NOT AT END
                       IF (file1-serial-1 <> w-count)
                           DISPLAY "FAIL 5"
                           SET abort TO TRUE
                       ELSE IF (w-count = 5 OR 10 OR 15 OR 20)
                           IF NOT ((file1-serial-2 = (1000 + w-count))
                                   AND (file1-xseen = 1))
                               DISPLAY "FAIL 6"
                               SET abort TO TRUE
                           END-IF
                       ELSE
                           IF NOT ((file1-serial-2 = (100 + w-count))
                                   AND (file1-xseen = 0))
                               DISPLAY "FAIL 7"
                               SET abort TO TRUE
                           END-IF
                       END-IF
               END-READ
           END-PERFORM
           CLOSE file1
           .