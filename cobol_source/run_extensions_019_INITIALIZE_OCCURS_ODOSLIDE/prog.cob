IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  p            USAGE POINTER.
       01  p2           USAGE POINTER.
       01  dlen         PIC 9(7).
       01  grp-0.
           05   FILLER  PIC X(3).
           05   FLD-0.
              10   FLD-0-1 OCCURS 8193 TIMES.
                15   FLD-0-2 PIC XXX VALUE "XYZ".
                15   FLD-0-3 PIC 99  VALUE 12.
                15   FLD-0-4 PIC XX  VALUE "QQ".
           05   FILLER  PIC X(3).
       01  grp-1.
           05   FILLER  PIC X(3).
           05   FLD-1   PIC X(5) VALUE ALL "ABCDE".
           05   FILLER  PIC X(3).
       01  grp-2.
           05   FILLER  PIC X(3).
           05   FLD-2   PIC X(42) VALUE ALL "ABCD ".
           05   FILLER  PIC X(3).
       01  grp-2a.
           05   FILLER  PIC X(3).
           05   FLD-2A  PIC X(8) VALUE ALL "ABC".
           05   FILLER  PIC X(3).
       01  grp-3.
           05   FILLER  PIC X(3).
           05   FLD-3   OCCURS 3 TIMES
                        VALUE ALL "ABC00XX".
                15   FLD-3-2 PIC XXX.
                15   FLD-3-3 PIC 99.
                15   FLD-3-4 PIC XX.
           05   FILLER  PIC X(3).
       01  grp-4.
           05   FILLER  PIC X(3).
           05   FLD-4.
              10   FLD-4-1 OCCURS 11 TIMES.
                15   FLD-4-2 PIC XX  VALUE "AB".
                15   FLD-4-3 PIC 99  VALUE 12.
                15   FLD-4-4 PIC XX  VALUE "YZ".
           05   FILLER  PIC X(3).

       77  C5    PIC 9(03)  VALUE 6.
       01  grp-5.
           05   FILLER  PIC X(3).
           05   FLD-5.
              10   FLD-5-1 OCCURS 0 TO 9 TIMES
                        DEPENDING ON C5.
                15   FLD-5-2 PIC XXX VALUE "Mon".
                15   FLD-5-3 PIC 99  VALUE 49.
                15   FLD-5-4 PIC XX  VALUE "ey".
           05   FILLER  PIC X(3).

       PROCEDURE DIVISION.
           MOVE ALL "*" TO grp-1.
           INITIALIZE FLD-1 ALL TO VALUE.
           DISPLAY "GRP-1:" grp-1.

           MOVE ALL "*" TO grp-2.
           INITIALIZE FLD-2 ALL TO VALUE.
           DISPLAY "GRP-2:" grp-2.

           MOVE ALL "*" TO grp-3.
           INITIALIZE FLD-3 (1) ALL TO VALUE.
           INITIALIZE FLD-3 (2) ALL TO VALUE.
           INITIALIZE FLD-3 (3) ALL TO VALUE.
           DISPLAY "GRP-3:" grp-3.

           MOVE ALL "*" TO grp-4.
           INITIALIZE FLD-4 ALL TO VALUE.
           DISPLAY "GRP-4:" grp-4.

           MOVE 7       TO c5.
           MOVE ALL "*" TO grp-5.
           INITIALIZE FLD-5 ALL TO VALUE.
           DISPLAY "GRP-5:" grp-5.