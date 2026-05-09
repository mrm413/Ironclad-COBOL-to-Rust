IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  p            USAGE POINTER.
       01  p2           USAGE POINTER.
       01  dlen         PIC 9(7).

       LINKAGE SECTION.
       01  a-table.
           03  prefix.
               05  n    PIC 9(03)  VALUE 123.
           03  table-data value all "ABCDE".
            04  rows    OCCURS 0 TO UNBOUNDED TIMES
                        DEPENDING ON n.
               05 col1  PIC X.
               05 col2  PIC X(02).

       PROCEDURE DIVISION.
           ALLOCATE LENGTH OF prefix CHARACTERS
                    RETURNING p
           SET ADDRESS OF a-table TO p
           INITIALIZE prefix ALL TO VALUE
           IF FUNCTION LENGTH (a-table) NOT = 372
              DISPLAY 'WRONG LENGTH table: ' FUNCTION LENGTH (a-table).
           ALLOCATE FUNCTION LENGTH (a-table) CHARACTERS
                    RETURNING p2
           SET ADDRESS OF a-table TO p2
           FREE p

           INITIALIZE prefix ALL TO VALUE

           IF LENGTH OF a-table NOT = 372
              MOVE LENGTH OF a-table TO dlen
              DISPLAY "BAD SIZE: " dlen.

           INITIALIZE table-data (1:FUNCTION LENGTH(rows(1)) * n)
                      ALL TO VALUE
           IF col2(1) NOT = "BC"
              DISPLAY "col2(1) wrong: " col2(1).
           IF rows(2) NOT = "DEA"
              DISPLAY "rows(2) wrong: " rows(2).

      *> check if ref-mod also works as expected
           MOVE 2 TO n
           MOVE ALL ZEROES TO a-table (1: (LENGTH OF a-table))
           MOVE 7 TO n
           IF rows(2) NOT = "000"
              DISPLAY "rows(2) after ref-mod MOVE wrong: " rows(2).
           IF rows(3) NOT = "BCD"
              DISPLAY "rows(3) after ref-mod MOVE wrong: " rows(3).
           MOVE ALL '9' TO rows (5) rows (7)

      *> Test -  should only initialize up to current size, not max:
           MOVE 4 TO n
           INITIALIZE table-data     TO DEFAULT
           MOVE 7 TO n
           IF rows(2) NOT = SPACES OR
              rows(4) NOT = SPACES
              DISPLAY "rows(2/4) after init default wrong: "
                       rows(2) rows(4).
           IF rows(5) NOT = "999"
              DISPLAY "rows(5) after init default wrong: " rows(5).

           MOVE 6 TO n
           INITIALIZE table-data ALL TO VALUE
           MOVE 9 TO n
           IF rows(5) NOT = "CDE"
              DISPLAY "rows(5) after init value wrong: " rows(5).
           IF rows(7) NOT = "999"
              DISPLAY "rows(7) after init value wrong: " rows(7).

           IF a-table (20:10) NOT = "BC999BCDEA"
              DISPLAY "a-table / ref-mod wrong: " a-table (20:10).
           move 10 to n
           IF a-table (20:n) NOT = "BC999BCDEA"
              DISPLAY "a-table / ref-mod length wrong: " a-table (20:n).
           move 20 to n
           IF a-table (n:10) NOT = "BC999BCDEA"
              DISPLAY "a-table / ref-mod offset wrong: " a-table (n:10).

      *> Test - FUNCTION LENGTH(table-data) must be resolved at run-time
           MOVE 8 TO n
           INITIALIZE table-data (1:FUNCTION LENGTH(table-data))
              ALL TO VALUE
           .

           DISPLAY a-table (20:10). *> expect runtime error