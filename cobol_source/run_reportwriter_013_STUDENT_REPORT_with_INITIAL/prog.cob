IDENTIFICATION DIVISION.
       PROGRAM-ID. prog INITIAL.
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
               05  NUM-COURSES              PIC  99.

       FD   PRINT-FILE
             REPORT IS STUDENT-REPORT STUDENT-REPORT2.

       WORKING-STORAGE SECTION.
       01   ARE-THERE-MORE-RECORDS       PIC  XXX   VALUE  "YES".

       REPORT SECTION.
       RD   STUDENT-REPORT
           PAGE LIMIT 30 LINES
           HEADING 2
           FIRST DETAIL 3
           LAST DETAIL 25
           FOOTING 28.
       01   REPORT-LINE
            TYPE DETAIL
             LINE PLUS  1.
            05  COLUMN 1 PIC 9(2) 
                  SOURCE LINE-COUNTER OF STUDENT-REPORT.
            05  COLUMN 4      PIC 9(6)     SOURCE    STUDENT-ID.
            05  COLUMN 15     PIC X(20)    SOURCE    STUDENT-NAME.
            05  COLUMN 40     PIC XXX      SOURCE    MAJOR.
            05  COLUMN 45     PIC XXX      VALUE "-*-".
            05  COLUMN 52     PIC 99       SOURCE    NUM-COURSES.

       RD  STUDENT-REPORT2
           PAGE LIMIT 60 LINES
           HEADING 2
           FIRST DETAIL 5
           LAST DETAIL 55
           FOOTING 58.
       01   REPORT-LINE2
            TYPE DETAIL
             LINE PLUS  1.
            05  COLUMN 4      PIC 9(6)     SOURCE    STUDENT-ID.
            05  COLUMN 15     PIC X(20)    SOURCE    STUDENT-NAME.
            05  COLUMN 40     PIC XXX      SOURCE    MAJOR.
            05  COLUMN 45     PIC 99       SOURCE    NUM-COURSES.
       01   REPORT-LINE3
            TYPE DETAIL
             LINE PLUS  2.
            05  COLUMN 4      PIC 9(6)     SOURCE    STUDENT-ID.
            05  COLUMN 15     PIC X(20)    SOURCE    STUDENT-NAME.
            05  COLUMN 40     PIC XXX      SOURCE    MAJOR.

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