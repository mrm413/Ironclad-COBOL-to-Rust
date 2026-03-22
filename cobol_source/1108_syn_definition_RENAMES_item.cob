IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  a.
           03  b       PIC 9.
           03  c.
               05 d    PIC 9.
               05 e    PIC 9.

       66  valid-1     RENAMES b.
       66  valid-2     RENAMES d THRU e.

       66  invalid-1   RENAMES a.
       66  invalid-2   RENAMES c THRU d.
       66  invalid-3   RENAMES e THRU d.
       66  invalid-4   RENAMES valid-2.

       01  f.
           03  g       PIC X.
               88  h   VALUE "a".
           03  i       PIC X.
           03  j       OCCURS 5 TIMES.
               05  k   PIC X.
               05  l   PIC 9.
           03  m       PIC 9.
           03  n       POINTER, SYNC.
           03  o.
               05  p   PIC X OCCURS 1 TO 10 DEPENDING ON l.

       66  valid-3     RENAMES g THRU i.
       66  invalid-5   RENAMES h.
       66  invalid-6   RENAMES k THRU l.
       66  invalid-7   RENAMES j.
       66  invalid-8   RENAMES m THRU o.
       66  invalid-9   RENAMES b THRU m.
       
       78  my-ext-const VALUE "123".
       66  invalid-ec   RENAMES my-ext-const.
       
       01  my-std-const CONSTANT AS "123".
       66  invalid-sc   RENAMES my-std-const.

       PROCEDURE       DIVISION.
           DISPLAY valid-2 OF a
           IF valid-1 = 1
              CONTINUE
           END-IF
           .