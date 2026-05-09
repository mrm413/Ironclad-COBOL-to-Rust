IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL f ASSIGN "out.txt"
               SEQUENTIAL
               FILE STATUS f-status.

           SELECT g ASSIGN "out.txt"
               SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-rec PIC X.

       FD  g.
       01  g-rec PIC X.

       WORKING-STORAGE SECTION.
       01  f-status PIC XX.

       PROCEDURE DIVISION.
           OPEN OUTPUT f
           WRITE f-rec FROM "a"
           CLOSE f

           SET LAST EXCEPTION TO OFF
           >>TURN EC-I-O CHECKING ON
           *> Read f too many times without libcob error
           OPEN INPUT f
           PERFORM 2 TIMES
               READ f
               DISPLAY f-rec
           END-PERFORM

           DISPLAY f-status
           DISPLAY FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
           SET LAST EXCEPTION TO OFF

           CLOSE f

           >>TURN EC-I-O g CHECKING ON

           *> Read f too many times without libcob error
           OPEN INPUT f
           PERFORM 2 TIMES
               READ f
               DISPLAY f-rec
           END-PERFORM

           DISPLAY f-status
           DISPLAY FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
           SET LAST EXCEPTION TO OFF

           CLOSE f

           *> Read g too many times with libcob error
           OPEN INPUT g
           PERFORM 2 TIMES
               READ g
               DISPLAY g-rec
           END-PERFORM

           CLOSE g
           .