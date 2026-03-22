IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
               SELECT INPUT-FILE ASSIGN TO EXTERNAL STUDENT
                              ORGANIZATION IS LINE SEQUENTIAL.
               SELECT PRINT-FILE ASSIGN TO EXTERNAL 
                              LINE ADVANCING REPORT1.

       DATA DIVISION.
       FILE SECTION.
       FD   INPUT-FILE.
       01   INPUT-REC.
               05  STUDENT-ID               PIC  9(5).
               05  STUDENT-NAME             PIC  X(20).
               05  MAJOR                    PIC  XXX.
               05  NUM-COURSES              PIC  9(6).

       FD   PRINT-FILE
             BLOCK CONTAINS 0 RECORDS
             RECORDING MODE IS F
             RECORD CONTAINS 132 CHARACTERS
            REPORT IS STUDENT-REPORT.
       01   RW-REC  PIC X(90).

       WORKING-STORAGE SECTION.
       01   ARE-THERE-MORE-RECORDS       PIC  XXX   VALUE  "YES".

       REPORT SECTION.
       RD   STUDENT-REPORT
           PAGE LIMIT 30
           HEADING 1
           FIRST DETAIL  5
           LAST  DETAIL 25
           FOOTING 28
           LINE LIMIT 90
           .
       01 HEADING-LINE.
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE 
                "         1         2         3         4         5".
            05  COLUMN 51     PIC X(20) VALUE "         6         7".
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE 
                "12345678901234567890123456789012345678901234567890".
            05  COLUMN 51     PIC X(20) VALUE "12345678901234567890".
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(2)  VALUE "Ln".
            05  COLUMN 5      PIC X(6)  VALUE "--ID--".
            05  COLUMN 16     PIC X(20) VALUE "--------Name--------".
            05  COLUMN 39     PIC X(5)  VALUE "Major".
            05  COLUMN 45     PIC XXX   VALUE "*-*".
            05  COLUMN 54     PIC X(5)  VALUE "+Odd+".
            05  COLUMN 61     PIC X(6)  VALUE "+Even+".

       01 REPORT-LINE
          TYPE DETAIL LINE PLUS  1.
            05  COLUMN PLUS 1 PIC Z9   
                  SOURCE LINE-COUNTER OF STUDENT-REPORT.
            05  COLUMN LEFT PLUS 3   PIC Z(5)9 SOURCE STUDENT-ID.
            05  COLUMN CENTER 25     PIC X(20) SOURCE STUDENT-NAME.
            05  COLUMN RIGHT  43     PIC X(5)  SOURCE MAJOR.
            05  COLUMN        45     PIC XXX   VALUE ":-:".
            05  COLUMN CENTER 56     PIC Z(4)9 SOURCE NUM-COURSES.
            05  COLUMN CENTER 63     PIC Z(5)9 SOURCE NUM-COURSES.
            05  COLUMN        68     PIC X   VALUE ":".

       PROCEDURE DIVISION.
       A000-MAINLINE.
           OPEN  INPUT  INPUT-FILE
                 OUTPUT PRINT-FILE
           PERFORM DO-INIT.
           READ INPUT-FILE
               AT END
                   MOVE "NO" TO ARE-THERE-MORE-RECORDS.
           PERFORM A001-LOOP
               UNTIL ARE-THERE-MORE-RECORDS = "NO ".
           PERFORM DO-TERM.
           CLOSE INPUT-FILE
                 PRINT-FILE.
           STOP RUN.

       A001-LOOP.
           GENERATE REPORT-LINE.
           READ INPUT-FILE
               AT END
                   MOVE "NO " TO ARE-THERE-MORE-RECORDS.
       DO-INIT.
           INITIATE STUDENT-REPORT.

       DO-TERM.
           TERMINATE STUDENT-REPORT.