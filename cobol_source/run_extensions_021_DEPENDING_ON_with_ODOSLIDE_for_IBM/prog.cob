IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  L1-1-2-S    PIC 99.
       01  L1-1-2-1-S  PIC 99.
       01  L1-2-S      PIC 99.
       01  L1-3-S      PIC 99.
       01  L1-3-2-S    PIC 99.
       01  BUFFER      PIC X(370).

       PROCEDURE DIVISION.
           MOVE ALL '0123456789' TO BUFFER.
           MOVE 3 TO L1-1-2-S.
           MOVE 4 TO L1-1-2-1-S.
           MOVE 0 TO L1-2-S.
           MOVE 6 TO L1-3-S.
           MOVE 1 TO L1-3-2-S.
           CALL 'IBM-ODO-TEST' USING BUFFER
                               L1-1-2-S
                               L1-1-2-1-S
                               L1-2-S
                               L1-3-S
                               L1-3-2-S.

           MOVE ALL '0123456789' TO BUFFER.
           MOVE 2 TO L1-1-2-S.
           MOVE 3 TO L1-1-2-1-S.
           MOVE 1 TO L1-2-S.
           MOVE 4 TO L1-3-S.
           MOVE 0 TO L1-3-2-S.
           CALL 'IBM-ODO-TEST' USING BUFFER
                               L1-1-2-S
                               L1-1-2-1-S
                               L1-2-S
                               L1-3-S
                               L1-3-2-S.
           STOP RUN.
       END PROGRAM prog.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. IBM-ODO-TEST.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01  L1-1-2-S    PIC 99.
       01  L1-1-2-1-S  PIC 99.
       01  L1-2-S      PIC 99.
       01  L1-3-S      PIC 99.
       01  L1-3-2-S    PIC 99.
       01 BASE.
         10 ARRAY OCCURS 2 TIMES.
           20 L1-1.
             25 L1-1-1 PIC X(3).
             25 L1-1-2 OCCURS 4 TIMES DEPENDING ON L1-1-2-S.
               30 L1-1-2-1 OCCURS 5 TIMES DEPENDING ON L1-1-2-1-S
                  PIC XXX.
           20 L1-2 OCCURS 0 TO 1 TIMES DEPENDING ON L1-2-S PIC XX.
           20 L1-3 OCCURS 1 TO 10 TIMES DEPENDING ON L1-3-S.
             25 L1-3-1.
               30  L1-3-1-1 PIC X(5).
               30  L1-3-1-2 PIC X.
               30  L1-3-1-3 PIC X(5).
             25 L1-3-2 OCCURS 0 TO 1 TIMES DEPENDING ON L1-3-2-S PIC X.

       PROCEDURE DIVISION USING BASE
                                L1-1-2-S
                                L1-1-2-1-S
                                L1-2-S
                                L1-3-S
                                L1-3-2-S.
           DISPLAY "Length is " LENGTH OF BASE
                   " with " L1-1-2-S
                   ", " L1-1-2-1-S
                   ", " L1-2-S
                   ", " L1-3-S
                   ", " L1-3-2-S.
           MOVE '.'   TO L1-3-2(1, 5, 1).
           MOVE '--'  TO L1-2(2, 1).
           MOVE '+++' TO L1-1-2-1(2, 1, 5).
           DISPLAY '"' BASE '"'.
       END PROGRAM IBM-ODO-TEST.