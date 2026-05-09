IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL file1 ASSIGN "fileX"
               ORGANIZATION IS INDEXED
               RECORD KEY IS file1-key
               STATUS f-status.

       DATA DIVISION.
       FILE SECTION.
       FD  file1.
       01  file1-key PIC X.

       WORKING-STORAGE SECTION.
       01  f-status PIC XX.

       PROCEDURE DIVISION.
           DELETE FILE file1.
           OPEN INPUT file1.
           IF (f-status <> "05")
               DISPLAY "FAILED OPEN: fs=" f-status
           END-IF
           READ file1
               AT END
                   IF (f-status <> "10")
                       DISPLAY "FAILED READ AT END: fs=" f-status
                   END-IF

               NOT AT END
                   DISPLAY "FAILED READ NO AT END: status " f-status
           END-READ
           CLOSE file1
           .