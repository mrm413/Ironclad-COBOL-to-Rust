IDENTIFICATION DIVISION.
       PROGRAM-ID. prog2.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 K                 PIC 9(2).

       01 CNT1              PIC 9(9) COMP-5 VALUE 4.
       01 TAB1.
          05 ROW1 OCCURS 5        DESCENDING TAB1-NR.
             10 TAB1-NR     PIC 99 VALUE ZERO.
             10 TAB-DATA    PIC X(5).
       01 TAB2.
          05 ROW1 OCCURS 1 TO 4 DEPENDING CNT1
                                  DESCENDING TAB1-NR.
             10 TAB1-NR     PIC 99.
             10 TAB-DATA    PIC X(5).

       PROCEDURE DIVISION.
       A.
           DISPLAY TAB1-NR OF TAB1 (2) NO ADVANCING END-DISPLAY

           PERFORM VARYING K FROM 1 BY 1 UNTIL K > 4
             MOVE K     TO TAB1-NR  OF TAB2(K)
             MOVE 'BLA' TO TAB-DATA OF TAB2(K)
           END-PERFORM

           SORT ROW1 OF TAB2.

           PERFORM VARYING K FROM 1 BY 1 UNTIL K > 4
             DISPLAY TAB1-NR OF TAB2(K) NO ADVANCING END-DISPLAY
           END-PERFORM

           STOP RUN.