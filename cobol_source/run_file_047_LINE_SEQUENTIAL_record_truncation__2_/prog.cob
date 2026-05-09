IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFILE     ASSIGN TO EXTERNAL INFILE
                ORGANIZATION IS LINE SEQUENTIAL
                FILE STATUS  IS INPUT-STATUS .

           SELECT OUTFILE   ASSIGN TO EXTERNAL OUTFILE
                ORGANIZATION IS LINE SEQUENTIAL
                FILE STATUS  IS INPUT-STATUS .

       DATA DIVISION.
       FILE SECTION.
       FD INFILE
             RECORD IS VARYING IN SIZE FROM 18 TO 40 CHARACTERS
             DEPENDING ON INPUT-LEN
            .
       01  INPUT-REC           PIC X(40).

       FD OUTFILE
             RECORD IS VARYING IN SIZE FROM 18 TO 40 CHARACTERS
             DEPENDING ON INPUT-LEN
            .
       01  OUTPUT-REC          PIC X(40).

       WORKING-STORAGE SECTION.

       01  OUTPUT-FILE         PIC X(19)     VALUE 'TEST-FILE'.
       01  INPUT-FILE          PIC X(19)     VALUE 'TEST-INP'.
       01  INPUT-STATUS        PIC XX.
       01  INPUT-LEN           PIC 999  VALUE 18 .

       PROCEDURE DIVISION.
       A000-BEGIN.
           OPEN INPUT INFILE.
           READ INFILE
           DISPLAY " Read 1: STATUS IS " INPUT-STATUS
                   " LENGTH IS " INPUT-LEN
           DISPLAY "       :" INPUT-REC ":"
           READ INFILE
           DISPLAY " Read 2: STATUS IS " INPUT-STATUS
                   " LENGTH IS " INPUT-LEN
           DISPLAY "       :" INPUT-REC ":"
           MOVE 0 TO INPUT-LEN
           READ INFILE
           DISPLAY " Read 3: STATUS IS " INPUT-STATUS
                   " LENGTH IS " INPUT-LEN
           DISPLAY "       :" INPUT-REC ":"
           MOVE SPACES TO INPUT-REC
           MOVE 0 TO INPUT-LEN
           READ INFILE
           DISPLAY " Read 4: STATUS IS " INPUT-STATUS
                   " LENGTH IS " INPUT-LEN
           IF INPUT-STATUS (1:1) = "0"
               DISPLAY "       :" INPUT-REC ":"
           END-IF
           CLOSE INFILE

           OPEN OUTPUT OUTFILE
           MOVE 9 TO INPUT-LEN
           MOVE "Record 1............." TO OUTPUT-REC
           WRITE OUTPUT-REC
           DISPLAY "Write 1: STATUS IS " INPUT-STATUS
                   " LENGTH IS " INPUT-LEN
                             UPON CONSOLE
           MOVE 64 TO INPUT-LEN
           MOVE ALL '.' TO OUTPUT-REC
           MOVE "Record 2" TO OUTPUT-REC (1:8)
           WRITE OUTPUT-REC
           DISPLAY "Write 2: STATUS IS " INPUT-STATUS
                   " LENGTH IS " INPUT-LEN
                             UPON CONSOLE
           CLOSE OUTFILE
           STOP RUN.