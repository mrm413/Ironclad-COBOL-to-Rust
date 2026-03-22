IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  . *> the "filler" explicit checks bugs #699 and #776
           05  TAB-ENTRY1
                  OCCURS 5 TIMES
                  ASCENDING KEY IS X1
                                OF TAB-ENTRY1
                                OF TAB
                  INDEXED BY IDX1 OF TAB.
              10 X1 PIC 9.