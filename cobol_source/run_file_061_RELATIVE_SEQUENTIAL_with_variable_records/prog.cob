IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN DISK
               ORGANIZATION RELATIVE.

       DATA DIVISION.
       FILE SECTION.
       FD  f RECORD VARYING FROM 10 TO 20 DEPENDING rec-size.
       01  f-rec.
           02  f-x OCCURS 20 PIC X.

       WORKING-STORAGE SECTION.
       01  rec-size PIC 99.
       01  i PIC 99.
       01  1-template VALUE "+12345678++12345678+".
           02  1-x OCCURS 20 PIC X.

       PROCEDURE DIVISION.
           OPEN OUTPUT f
           PERFORM VARYING rec-size FROM 20 BY -1 UNTIL rec-size < 10
               WRITE f-rec FROM 1-template
           END-PERFORM
           CLOSE f

           OPEN INPUT f
      *    rec-size should not influence READ
           MOVE 15 TO rec-size
           PERFORM VARYING i FROM 20 BY -1 UNTIL i < 10
               READ f
                   AT END
                       DISPLAY "Failed: EOF"
                       STOP RUN ERROR
               END-READ

               DISPLAY rec-size ": >" f-rec (1:rec-size) "<"
               IF rec-size NOT = i
                   DISPLAY "Failed: bad record size"
                   STOP RUN ERROR
               END-IF
               IF f-x (rec-size) NOT = 1-x (rec-size)
                   DISPLAY "Failed: bad data"
                   STOP RUN ERROR
               END-IF
           END-PERFORM
           CLOSE f
           .