IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  a.
           03  b.
               05 c1 PIC X(3) VALUE "abc".
               05 c2 PIC 9(3) VALUE 0.
           03  d REDEFINES b.
               05  e PIC X(6).
           03  f PIC X OCCURS 3 VALUE "f".

       66  h RENAMES c1 THRU c2.

       01  out PIC X(60).

       PROCEDURE DIVISION.
           *> XML GENERATE out FROM a
           *> IF out <> '<a><b><c1>abc</c1><c2>0</c2></b><f>f</f><f>f</f>'-
           *>          '<f>f</f></a>'
           *>    DISPLAY "Failed 1: " FUNCTION TRIM (out)
           *> END-IF

           XML GENERATE out FROM d
           IF out <> '<d><e>abc000</e></d>'
               DISPLAY "Failed 2: " FUNCTION TRIM (out)
           END-IF
           .
       END PROGRAM prog.