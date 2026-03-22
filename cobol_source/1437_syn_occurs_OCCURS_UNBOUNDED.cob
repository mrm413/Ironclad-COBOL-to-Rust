IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       LINKAGE  SECTION.
       01 G-1.
          07 G-2-ELEMENTS   PIC 9(08).
          07 G-2
            OCCURS UNBOUNDED
            DEPENDING ON    G-2-ELEMENTS.
           10 X             PIC X.
        PROCEDURE DIVISION USING G-1.
           DISPLAY G-1.
           GOBACK.