IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  P2           USAGE POINTER.

       01 TAB-ADR-COUNT            PIC S9(4)      VALUE 8.

       01 TAB-ADR OCCURS 0 TO 1000 TIMES
            DEPENDING ON TAB-ADR-COUNT
            INDEXED BY TAB-ADR-IND.
          05 TAB-ADR-ELEMENT.
              10 TAB-ADR-PRGM         PIC X(8).
              10 TAB-ADR-ID           PIC X(2).
              10 TAB-ADR-ADR-64       PIC S9(16) COMP-5.
              10 TAB-ADR-LAST-ADR-64  PIC S9(16) COMP-5.

       01  GRP-X BASED.
           05   FILLER  PIC X(3).
           05   FLD-X   OCCURS 10 TIMES.
             10 FLD-X-Y   PIC 9999 VALUE 2020.
             10 FLD-X-M   PIC 99 VALUE 11.
             10 FLD-X-X   PIC X(128) VALUE "This is something ".
           05   FILLER  PIC X(3).

       01  GRP-1.
           05   FILLER  PIC X(3).
           05   FLD-1   OCCURS 10 TIMES.
             10 FLD-1-Y   PIC 9999 VALUE 2020.
             10 FLD-1-M   PIC 99 VALUE 11.
             10 FLD-1-X   PIC X(128) VALUE "This is something ".
           05   FILLER  PIC X(3).

       01  GRP-2.
           05   FILLER  PIC X(3).
           05   FLD-2   PIC X(42) VALUE ALL "ABCD ".
           05   FILLER  PIC X(3).
       01  GRP-2A.
           05   FILLER  PIC X(2).
           05   FLD-2A  PIC X(8) VALUE ALL "ABC".
           05   FILLER  PIC X(1200) VALUE "X".
       01  GRP-3.
           05   FILLER  PIC X(3).
           05   FLD-3   OCCURS 3 TIMES.
                15   FLD-3-2 PIC XXX VALUE "ABC".
                15   FLD-3-3 PIC 99  VALUE ZERO.
                15           OCCURS 4 VALUE ALL "D99".
                     25   FLD-3O-1 PIC X.
                     25   FLD-3O-2 PIC 99.
                15   FLD-3-4 PIC XX  VALUE ALL "X".
           05   FILLER  PIC X(3).

       77  C5    PIC 9(03)  VALUE 6.
       01  GRP-5.
           05   FILLER  PIC X(3).
           05   FLD-5.
              10   FLD-5-1 OCCURS 0 TO 9 TIMES
                        DEPENDING ON C5.
                15   FLD-5-2 PIC XXX VALUE "Mon".
                15   FLD-5-3 PIC 99  VALUE 49.
                15   FLD-5-4 PIC XX  VALUE "ey".

       LINKAGE SECTION.
       01  A-TABLE.
           03  prefix.
               05  n    PIC 9(03)  VALUE 123.
           03  table-data value all "ABCDE".
            04  rows    OCCURS 0 TO UNBOUNDED TIMES
                        DEPENDING ON n.
               05 col1  PIC X.
               05 col2  PIC X(02).

       PROCEDURE DIVISION.
           MOVE ALL "*" TO GRP-2
           INITIALIZE FLD-2 ALL TO VALUE
           DISPLAY "GRP-2:" GRP-2.
      *
           MOVE ALL "*" TO GRP-3
           INITIALIZE GRP-3 NUMERIC TO VALUE
           INITIALIZE FLD-3 (1) ALL TO VALUE
           INITIALIZE FLD-3 (2) ALL TO VALUE
           INITIALIZE FLD-3 (3) ALL TO VALUE
           INITIALIZE FLD-3O-1 (3,2), FLD-3O-2 (3,2)
           DISPLAY "GRP-3:" GRP-3.
      *
           MOVE 7       TO c5
           MOVE ALL "*" TO GRP-5
           INITIALIZE FLD-5 ALL TO VALUE
           DISPLAY "GRP-5:" GRP-5.
      *
           MOVE SPACES  TO GRP-2A
           MOVE "Peek"  TO GRP-2A (510:4)
           MOVE "Boo"   TO GRP-2A (910:3)
           MOVE X"FE99" TO GRP-2A (910:2)
           MOVE "You"   TO GRP-2A (1010:3)
           MOVE "$$"    TO FLD-5-4 (5)
           MOVE "Something else!" TO FLD-1-X (5).
      *
      *    "the initial value of an index-name at runtime is undefined"
      *    Old OpenCOBOL/GnuCOBOL did that as "1"
           SET TAB-ADR-IND           TO 1.
      *
           SET P2 TO NULL
           SET ADDRESS OF A-TABLE TO NULL
           MOVE ALL ZEROES TO A-TABLE (1: (LENGTH OF A-TABLE)).
      *
           STOP RUN.