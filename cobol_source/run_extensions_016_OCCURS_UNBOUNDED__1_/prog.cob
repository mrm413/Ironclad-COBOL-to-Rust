IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  N            PIC 9(03)  VALUE 123 COMP-5.
       01  P            USAGE POINTER.
       01  SAV          PIC X(8192).
       01  W-TABLE.
           03  WROWS     OCCURS 0 TO 500 TIMES
                        DEPENDING ON N.
               05 WCOL1  PIC 9.
               05 WCOL2  PIC X(02).

       LINKAGE SECTION.
       01  A-TABLE.
           03  ROWS     OCCURS 0 TO UNBOUNDED TIMES
                        DEPENDING ON N.
               05 COL1  PIC X.
               05 COL2  PIC X(02).

       PROCEDURE DIVISION.
           IF FUNCTION LENGTH (W-TABLE) NOT = 369
              DISPLAY 'WRONG WS LENGTH: ' FUNCTION LENGTH (A-TABLE)
              END-DISPLAY
           END-IF
           IF FUNCTION LENGTH (A-TABLE) NOT = 369
              DISPLAY 'WRONG LS LENGTH: ' FUNCTION LENGTH (A-TABLE)
              END-DISPLAY
           END-IF
           ALLOCATE FUNCTION LENGTH (A-TABLE) CHARACTERS
                    INITIALIZED TO ALL "ABCDE"
                    RETURNING P
           SET ADDRESS OF A-TABLE TO P
           IF COL2(1) NOT = "BC"
              DISPLAY "col2(1) wrong: " col2(1)
           END-IF
           IF ROWS(2) NOT = "DEA"
              DISPLAY "rows(2) wrong: " rows(2)
           END-IF
      *
           INITIALIZE W-TABLE
      *
           MOVE A-TABLE TO SAV
           INITIALIZE A-TABLE
      *
           FREE p
           .