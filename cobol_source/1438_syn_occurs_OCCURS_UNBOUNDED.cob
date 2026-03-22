IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       LINKAGE  SECTION.
       01 G-1.
         05 G-1-F1          PIC X(22).
         05 G-1-F2          PIC X(12).
         05 G-2.
          07 G-3-ELEMENTS   PIC 9(08).
          07 G-3
            OCCURS UNBOUNDED
            DEPENDING ON    G-3-ELEMENTS.
           10 G-4.
             15 X           PIC  9(22).
        PROCEDURE DIVISION USING G-1.
           DISPLAY G-1.
           GOBACK.