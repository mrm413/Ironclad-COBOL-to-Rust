IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  TAB.
           05  TAB-ENTRY1
                  OCCURS 5 TIMES
                  INDEXED BY IDX1
                  ASCENDING KEY IS X1
                  DESCENDING Y1.
             10  X1 PIC 9(4).
             10  Y1 PIC X.
           05  TAB-ENTRY
                  OCCURS 2 TIMES
                  INDEXED BY IDX2
                  DESCENDING KEY IS X2
                  ASCENDING  Y2.
             10  X2 PIC 9(4).
             10  Y2 PIC X.