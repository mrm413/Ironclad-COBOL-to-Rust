IDENTIFICATION DIVISION.
       PROGRAM-ID. OUTER-PROGRAM.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STCK-FILE
              ASSIGN TO "STOCK"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS RANDOM
              FILE STATUS IS STCK-FILE-STATUS
              RECORD People-LastName
              ALTERNATE People-NameKey
                 SOURCE People-FirstName People-LastName
              ALTERNATE People-NameKeyFirst
                 SOURCE People-1stName
              *> validating internal error handling:
              ALTERNATE BadKey People-1stName.
           SELECT LOCAL-FILE
              ASSIGN TO "LOCAL"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS RANDOM
              FILE STATUS IS LOCL-FILE-STATUS
              RECORD LPeople-LastName
              ALTERNATE LPeople-NameKey
                 SOURCE LPeople-FirstName LPeople-LastName.

       DATA DIVISION.
       FILE SECTION.

       FD  STCK-FILE GLOBAL.
       01  STCK-REC.
           02 People-LastName      PIC X(50).
           02 People-FirstName     PIC X(50).
       01  STCK-REC-PART.
           02 People-1stName       PIC X(50).

       FD  LOCAL-FILE.
       01  LOCAL-REC.
           02 LPeople-LastName     PIC X(50).
           02 LPeople-FirstName    PIC X(50).

       WORKING-STORAGE SECTION.

       01  FILE-STATES IS GLOBAL.
           03  STCK-FILE-STATUS        PIC XX.
               88  STCK-FILE-OK        VALUE "00".
           03  LOCL-FILE-STATUS        PIC XX.
               88  LOCL-FILE-OK        VALUE "00".

       PROCEDURE DIVISION.

         MAIN SECTION.

           OPEN OUTPUT LOCAL-FILE
           MOVE "John" TO LPeople-FirstName
           MOVE "Doe"  TO LPeople-LastName
           WRITE LOCAL-REC
           CLOSE LOCAL-FILE

           OPEN OUTPUT STCK-FILE
           MOVE "John" TO People-FirstName
           MOVE "Doe"  TO People-LastName
           WRITE STCK-REC
           CLOSE STCK-FILE
           
           CALL "INNER-PROGRAM".
           GOBACK.

       PROGRAM-ID. INNER-PROGRAM.
       PROCEDURE DIVISION.
           OPEN INPUT STCK-FILE
           MOVE "John" TO People-FirstName
           MOVE "Doe"  TO People-LastName
           READ STCK-FILE KEY People-NameKey
             NOT INVALID KEY
                DISPLAY People-FirstName " " People-LastName
             INVALID KEY
                DISPLAY "NOT FOUND"
           END-READ
           INITIALIZE STCK-REC
           MOVE "John" TO People-1stName
           READ STCK-FILE KEY People-NameKeyFirst
             NOT INVALID KEY
                DISPLAY People-FirstName " " People-LastName
             INVALID KEY
                DISPLAY "NOT FOUND"
           END-READ
           CLOSE STCK-FILE
           OPEN INPUT LOCAL-FILE
           MOVE "John" TO LPeople-FirstName
           MOVE "Doe"  TO LPeople-LastName
           READ LOCAL-FILE KEY LPeople-NameKey
             NOT INVALID KEY
                DISPLAY LPeople-FirstName " " LPeople-LastName
             INVALID KEY
                DISPLAY "NOT FOUND"
           END-READ
           CLOSE LOCAL-FILE
           GOBACK.
       END PROGRAM INNER-PROGRAM.
      *>****************************************************************
       END PROGRAM OUTER-PROGRAM.