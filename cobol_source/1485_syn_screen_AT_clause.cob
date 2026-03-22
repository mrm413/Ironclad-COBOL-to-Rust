IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  curs-1      PIC 9(4) VALUE 00000000001111.
       01  curs-2.
           03  linee   PIC 999.
           03  coll    PIC 999.
       01  posc        CONSTANT 0101.

       01  curs-3      PIC 99.
       01  curs-4      PIC 9(8) VALUE 0101.
       01  curs-5      PIC X(4).

       01  SCREEN-POS.
           03  SPOS            PIC  9(04) VALUE ZERO.
           03  WS2-CURS REDEFINES SPOS.
               05  SLIN        PIC  9(02).
               05  SCOL        PIC  9(02).

       PROCEDURE       DIVISION.
           *> Valid AT clauses
           DISPLAY "a" AT curs-1
           DISPLAY "a" AT curs-2
           DISPLAY "a" AT posc
           DISPLAY "a" AT posc
           DISPLAY "a" AT SPOS
           DISPLAY "a" AT WS2-CURS
           DISPLAY "a" AT SCREEN-POS

           *> Invalid AT clauses
           DISPLAY "a" AT curs-3
           DISPLAY "a" AT curs-4
           DISPLAY "a" AT curs-5
           DISPLAY "a" AT 101
           DISPLAY "a" AT ZERO
           .