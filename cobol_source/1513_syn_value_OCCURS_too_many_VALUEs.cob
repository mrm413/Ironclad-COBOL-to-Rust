IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS.
         05  IX1  PIC 99.
         05  IX2  PIC 99.
         05  IX3  PIC 99.
         05  GRP1 OCCURS 3 TIMES.
             10  GRPX  PIC X(99).
         05  MONTH-IN-YEAR OCCURS 13 TIMES PICTURE X(3)
                         VALUES "jan" "feb" "mar" "apr"
                               "may" "jun" "jul" "aug"
                               "sep" "oct" "nov" "dec"
                               "Hi" "Bye" "Dog".
         05  DAYS-IN-MONTH OCCURS 13 TIMES PICTURE 9(2) BINARY
                         VALUES 31 28 31 30 31 30 31 31 30 31 30 31.
         05  DAYS-MONTHS  OCCURS 2 TIMES.
          06  DAYX-MONTHX OCCURS 4 TIMES.
           07  DAY-MONTH  OCCURS 3 TIMES.
             10  XXX1   PICTURE X VALUE " ".
             10  MONTHS PICTURE X(3)
                        VALUES "Jan" "Feb" "Mar" "Apr"
                               "May" "Jun" "Jul" "Aug"
                               "Sep" "Oct" "Nov" "Dec"
                               "JAN" "FEB" "MAR" "APR"
                               "MAY" "JUN" "JUL" "AUG"
                               "SEP" "OCT" "NOV" "DEC" "Bye".
             10  SEPX   PICTURE XX VALUE ", ".
             10  DAYS   PICTURE 99
                        VALUES 31 28 31 30 31 30 31 31 30 31 30 31
                               91 28 91 90 91 90 91 91 90 91 90 91.
             10  PER    PICTURE X VALUE ".".
           07  FLR    PICTURE X(4) VALUES " <A>" " <B>" " <C>" " <D>"
                                  " <E>" " <F>" " <G>" " <H>" " <*>".

       PROCEDURE DIVISION.

       INIT-RTN.
           DISPLAY "Simple OCCURS with multi VALUES".
           PERFORM VARYING IX1 FROM 1 BY 1 UNTIL IX1 > 13
              DISPLAY IX1 ": "
                      MONTH-IN-YEAR (IX1) " has "
                      DAYS-IN-MONTH (IX1) " days"
              END-DISPLAY
           END-PERFORM.
           DISPLAY "Complex OCCURS with multi VALUES".
           PERFORM VARYING IX3 FROM 1 BY 1 UNTIL IX3 > 2
             PERFORM VARYING IX2 FROM 1 BY 1 UNTIL IX2 > 4
                 DISPLAY IX3 "-" IX2 ": "
                         DAYX-MONTHX (IX3, IX2)
                 END-DISPLAY
             END-PERFORM
           END-PERFORM.
           STOP RUN.