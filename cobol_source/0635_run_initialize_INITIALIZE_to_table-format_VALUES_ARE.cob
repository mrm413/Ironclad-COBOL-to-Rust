IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  GRP-3.
           05   FILLER  PIC X(3).
           05   FLD-3   OCCURS 3 TIMES.
                15   FLD-3-2 PIC XXX VALUES "ABC".
                15   FLD-3-3 PIC 99  VALUES ZERO.
                15           OCCURS 4 VALUE ALL "D99".
                     25   FLD-3O-1 PIC X.
                     25   FLD-3O-2 PIC 99.
                15   FLD-3-4 PIC XX  VALUE ALL "X".
           05   FILLER  PIC X(3).
           05   FILLER  PIC X(3) VALUES "End".  *> needs relaxed

       77  C5    PIC 9(03)  VALUE 6.
       01  GRP-5.
           05   FILLER  PIC X(3).
           05   FLD-5.
              10   FLD-5-1 OCCURS 0 TO 9 TIMES
                        DEPENDING ON C5.
                15   FLD-5-2 PIC XXX VALUES "Mon".
                15   FLD-5-3 PIC 99  VALUES 49.
                15   FLD-5-4 PIC XX  VALUES "ey".
           05   FILLER  PIC X(3).

       01  WS.
         05  IX1  PIC 99.
         05  IX2  PIC 99.
         05  IX3  PIC 99.
         05  GRP1 OCCURS 3 TIMES.
             10  GRPX  PIC X(99).
         05  MONTH-IN-YEAR OCCURS 13 TIMES PICTURE X(3)
                        VALUES "jan" "feb" "mar" "apr"
                               "may" "jun" "jul" "aug"
                               "sep" "oct" "nov" "dec".
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
                               "SEP" "OCT" "NOV" "DEC".
             10  SEPX   PICTURE XX VALUE ", ".
             10  DAYS   PICTURE 99
                        VALUES 31 28 31 30 31 30 31 31 30 31 30 31
                               91 28 91 90 91 90 91 91 90 91 90 91.
             10  PER    PICTURE X VALUE ".".
           07  FLR    PICTURE X(4) VALUES " <A>" " <B>" " <C>" " <D>"
                                          " <E>" " <F>" " <G>" " <*>".

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
           DISPLAY "Group VALUE test".
           DISPLAY GRP-3 ".".
           INITIALIZE GRP-3 NUMERIC TO VALUE
           DISPLAY GRP-3 ".".
           INITIALIZE FLD-3 (1) ALL TO VALUE
           INITIALIZE FLD-3 (2) ALL TO VALUE
           INITIALIZE FLD-3 (3) ALL TO VALUE
           INITIALIZE FLD-3O-1 (3,2), FLD-3O-2 (3,2)
           DISPLAY GRP-3 ".".
           DISPLAY "Initialize VALUE OCCURS DEPENDING test".
           MOVE 6 TO C5.
           MOVE ALL "*" TO grp-5.
           INITIALIZE FLD-5 ALL TO VALUE.
           DISPLAY "GRP-5 with 6:" grp-5 ".".
           MOVE 4 TO C5.
           MOVE ALL "*" TO grp-5.
           INITIALIZE FLD-5 ALL TO VALUE.
           DISPLAY "GRP-5 with 4:" grp-5 ".".

      *
      * The following gets very complicated because of multiple
      * VALUES in the sub-fields, still works :-)
      *
           MOVE 1 TO IX3 MOVE 2 TO IX2.
           DISPLAY IX3 "-" IX2 ": " DAYX-MONTHX (IX3, IX2) ".".
           MOVE ALL "*" TO DAYX-MONTHX (IX3, IX2).
           DISPLAY IX3 "-" IX2 ": " DAYX-MONTHX (IX3, IX2) ".".
           INITIALIZE DAYX-MONTHX (IX3, IX2).
           DISPLAY IX3 "-" IX2 ": " DAYX-MONTHX (IX3, IX2) ".".
           DISPLAY "Initialize VALUE inside OCCURS test".
           INITIALIZE DAYX-MONTHX (IX3, IX2) ALL TO VALUE.
           DISPLAY IX3 "-" IX2 ": " DAYX-MONTHX (IX3, IX2) ".".
           STOP RUN.