IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 FIELD-A  PIC X(06) VALUE "ms-cob".
       01 A        PIC X.
       PROCEDURE        DIVISION.
           DISPLAY ERASE
           MOVE 10 TO LIN. MOVE 15 TO COL.
           DISPLAY (LIN , COL - 3) FIELD-A.
           DISPLAY (LIN + 1 , COL) FIELD-A.
           ACCEPT  (   , 10) A.
           DISPLAY (08 , 12) FIELD-A.
           ACCEPT  (   , 08) A WITH NO-ECHO.
           DISPLAY FIELD-A AT LINE 06  COLUMN 12.
           ACCEPT  A       AT COLUMN 8.
           SUBTRACT 2 FROM LIN.
           SUBTRACT 3 FROM COL.
           DISPLAY FIELD-A AT LINE LIN COLUMN COL.
           ACCEPT  (   , 10) A.
           DISPLAY ( 1 , 1 ) ERASE.
           DISPLAY ( 2 , 1 ) "Field value : ", FIELD-A.
           DISPLAY ( 3 , 1 ) A " --> A value"
           DISPLAY ( 5 , 1 ) "Press ENTER to exit".
           ACCEPT (11 , 1 ) A.
           STOP RUN.