IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G-1.
         05 G-1-F1      PIC  X(002).
         05 G-2.
          07 G-3
            OCCURS 1 TO 99999
            DEPENDING ON     G-3-ELEMENTS
            ASCENDING KEY IS G-4-KEY
            INDEXED BY       IND.
           10 G-4.
             15 N       PIC  9(001).
      *