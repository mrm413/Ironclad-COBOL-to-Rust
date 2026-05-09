IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN DISK
               INDEXED
               RECORD KEY f-key
               ACCESS RANDOM.

       DATA DIVISION.
       FILE SECTION.
       FD  f RECORD VARYING FROM 12 TO 22 DEPENDING rec-size.
       01  f-rec.
           02  f-key PIC 99.
           02  f-data.
               03  f-x OCCURS 20 PIC X.

       WORKING-STORAGE SECTION.
       01  rec-size PIC 99.
       01  1-template VALUE "+12345678++12345678+".
           02  1-x OCCURS 20 PIC X.

       PROCEDURE DIVISION.
           OPEN OUTPUT f
           MOVE 1 TO f-key
           PERFORM VARYING rec-size FROM 22 BY -1 UNTIL rec-size < 12
               MOVE 1-template TO f-data
               WRITE f-rec
               ADD 1 TO f-key
           END-PERFORM
           CLOSE f

           OPEN INPUT f
      *    rec-size should not influence READ
           MOVE 15 TO rec-size
           PERFORM VARYING f-key FROM 1 BY 1 UNTIL f-key > 11
               READ f
                   AT END
                       DISPLAY "Failed: EOF"
                       STOP RUN ERROR
               END-READ

               DISPLAY rec-size ": >" f-rec (3:rec-size - 2) "<"
               IF rec-size NOT = (22 - f-key) + 1
                   DISPLAY "Failed: bad record size - " rec-size
                   STOP RUN ERROR
               END-IF
               IF f-x (rec-size - 2) NOT = 1-x (rec-size - 2)
                   DISPLAY "Failed: bad data - " f-data
                   STOP RUN ERROR
               END-IF
           END-PERFORM
           CLOSE f
           .