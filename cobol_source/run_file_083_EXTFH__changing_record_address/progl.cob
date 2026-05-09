IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT  SECTION.
       FILE-CONTROL.
           SELECT OUTFILE
           ASSIGN "TEST1EXTFH"
           ORGANIZATION INDEXED
           RECORD KEY IS PRIME-KEY
           ACCESS IS SEQUENTIAL
           FILE STATUS IS OUT-STAT.

       DATA DIVISION.
       FILE SECTION.
       FD OUTFILE
           BLOCK CONTAINS 5 RECORDS.

       01  OUT-REC.
           05  PRIME-KEY PIC X(25).
           05  IN-DATA   PIC X(10).

       WORKING-STORAGE SECTION.
       01  OUT-STAT             PIC XX    VALUE '00'.
       01  OUT-RECNUM           PIC 9 VALUE 0.

       PROCEDURE DIVISION.
       MAIN-100.
           OPEN OUTPUT OUTFILE.
           IF OUT-STAT NOT = '00'
               DISPLAY 'ERROR ' OUT-STAT ' OPENING OUTPUT FILE'
               STOP RUN
           END-IF.
           INITIALIZE OUT-REC.

       GET-NEXT-100.
           ADD 1  TO OUT-RECNUM.
           MOVE "RECORD-X" TO PRIME-KEY.
           MOVE OUT-RECNUM TO PRIME-KEY (8:1).
           WRITE OUT-REC.
           IF  OUT-STAT NOT = '00'
           AND OUT-STAT NOT = '02'
               DISPLAY 'ERROR ' OUT-STAT ' WRITING OUTPUT'
               GO TO END-PROG-100
           END-IF.
           IF OUT-RECNUM < 5
               GO TO GET-NEXT-100.

       END-PROG-100.
           DISPLAY OUT-RECNUM ' records written'.
           CLOSE OUTFILE.
           STOP RUN.