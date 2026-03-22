IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.  *> taken from "commit and rollback example"
                          *> from COBOL 202x draft
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STCK-FILE
              ASSIGN TO "STOCK"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS RANDOM
              FILE STATUS IS STCK-FILE-STATUS
              RECORD KEY  IS APPLY
              SHARING WITH ALL OTHER.

           SELECT CHNG-FILE
              ASSIGN TO "CHANGE"
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS CHNG-FILE-STATUS
              SHARING WITH ALL OTHER.

           SELECT SORT-FILE
              ASSIGN TO "SORT".

       I-O-CONTROL.
           APPLY COMMIT ON STCK-FILE CHNG-FILE STCK-FILE not-there
                 SORT-FILE UPDATE-COUNT not-there-again BASED-STUFF
                 RED-DATA SOME-DATA.

       DATA DIVISION.
       FILE SECTION.

       FD  STCK-FILE.
       01  STCK-REC.
           03  APPLY                   PIC X(5).
           03  STCK-QTY                PIC 9(5)V99.

       SD  SORT-FILE.
       01  SORT-REC                    PIC X(100).

       FD  CHNG-FILE.
       01  CHNG-REC.
           03  CHNG-KEY                PIC X(5).
           03  CHNG-QTY                PIC 9(5)V99.
           03  CHNG-ACTION             PIC X.
           03  CHNG-STATE              PIC X.

       WORKING-STORAGE SECTION.

       01  FILE-STATES.
           03  STCK-FILE-STATUS        PIC XX.
               88  STCK-FILE-OK                  VALUE "00".
           03  CHNG-FILE-STATUS        PIC XX.
               88  CHNG-FILE-OK                  VALUE "00".
       77  UPDATE-COUNT  BINARY-LONG.
       77  BASED-STUFF   PIC X BASED.
       01  DATA-HERE.
           03 SOME-DATA  PIC 9.
       01  RED-DATA REDEFINES DATA-HERE PIC X.

       PROCEDURE DIVISION.

         MAIN SECTION.

           PERFORM INITIALISATION
           PERFORM TERMINATION
           STOP RUN WITH NORMAL STATUS 0

       . INITIALISATION SECTION.

           OPEN I-O CHNG-FILE, STCK-FILE
           IF NOT STCK-FILE-OK OR NOT CHNG-FILE-OK
              PERFORM FATAL-ERROR
           END-IF

       . TERMINATION SECTION.

           COMMIT
           IF NOT STCK-FILE-OK OR NOT CHNG-FILE-OK
              PERFORM FATAL-ERROR
           END-IF

       . FATAL-ERROR SECTION.

           ROLLBACK
           STOP RUN WITH ERROR STATUS 16.