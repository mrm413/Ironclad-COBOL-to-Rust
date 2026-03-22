IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN "f.txt" FILE STATUS fs.
           SELECT g ASSIGN "g.txt" FILE STATUS gs.
           SELECT h ASSIGN "h.txt" FILE STATUS hs.
           SELECT j ASSIGN "j.txt" FILE STATUS js.
           SELECT k ASSIGN "k.txt" FILE STATUS ks.
           SELECT l ASSIGN "l.txt" FILE STATUS ls.
           SELECT m ASSIGN "m.txt" FILE STATUS ms.
           SELECT n ASSIGN "n.txt" FILE STATUS ns.
           SELECT o ASSIGN "o.txt" FILE STATUS os.
           SELECT p ASSIGN "p.txt" FILE STATUS ps.
           SELECT q ASSIGN "q.txt" FILE STATUS non-existent.
           SELECT r ASSIGN "r.txt" FILE STATUS rs.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  hs    PIC XX.
       FD  g.
       01  g-rec PIC X.
       FD  h.
       01  h-rec PIC X.
       FD  j.
       01  j-rec PIC X.
       FD  k.
       01  k-rec PIC X.
       FD  l.
       01  l-rec PIC X.
       FD  m.
       01  m-rec PIC X.
       FD  n.
       01  n-rec PIC X.
       FD  o.
       01  o-rec PIC X.
       FD  p.
       01  p-rec PIC X.
       FD  q.
       01  q-rec PIC X.
       FD  r.
       01  r-rec PIC X.
       
       WORKING-STORAGE SECTION.
       *> Valid
       01  fs          PIC XX.

       LOCAL-STORAGE   SECTION.
       *> Valid, but warning
       01  gs          PIC 99.

       *> Invalid
       01  js          PIC N.
       01  ks          PIC XX COMP-X.
       01  ls          PIC V99.
       01  ms          PIC 99PP.
       01  ns          PIC XXX.
       01  x.
           03  y       PIC 99.
           03  z       PIC XX OCCURS 1 TO 10 TIMES DEPENDING ON y.
           03  os      PIC XX.
               88  ps  VALUE "00".
           03  z2      PIC XX OCCURS 1 TO 10 TIMES DEPENDING ON y.

       01  rs          CONSTANT "00".

       PROCEDURE DIVISION.
           CONTINUE
           .
       END PROGRAM prog.